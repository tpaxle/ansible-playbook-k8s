#!/usr/bin/env bash
ENV=$1
INFRA_UNIT=$2
ACTION=$3

EXTRA_ARGS=(${@:4})

set -e
[[ ! $(dirname "$0") == "." ]] && echo "You need to run this script from ." && exit 1
if [[ -z "${INFRA_UNIT_DIR}" ]]; then
  INFRA_UNIT_DIR="$(pwd)/cloud-aws/src/projects/"
#else
#  echo "Using current env INFRA_UNIT_DIR=${INFRA_UNIT_DIR}"
fi


CONFIG_DIR="$(pwd)/envs"

TF_DATA_DIR="${INFRA_UNIT_DIR}/${INFRA_UNIT}/.terraform/state"
TF_PLUGIN_CACHE_DIR="$(pwd)/.terraform/plugins"

usage(){
  echo "Usage: $0"
  echo
  echo "  ./tf.sh <environment> <infra-unit> <action> [tf options]"
  echo
  echo "or alternatively:"
  echo
  echo "  [assume-role <target-role>] ./tf.sh <environment> <infra-unit> <action> <target-role> [tf options]"
  echo "  --> migrated to ./tf.sh  <target-role> <environment> <infra-unit> <action> [tf options]"
  echo "Variable overview:"
  echo "  <target-role> - the role in which to run the script as (hint: your roles have been defined under ~/.aws/config)"
  echo "  <environment> - the target environment. Available environments: [ 'sandbox', 'dev', 'preprod', 'prod' ]"
  echo "  <infra-unit> - the module/directory to apply the <action> to, as shown under the './infra/' directory"
  echo "  <action> - the action to apply to the <infra-unit>. Available actions: "
  echo "        [ 'plan', 'apply', 'destroy', 'ciplan', 'ciapply', 'cidestroy', 'print', 'custom', 'fmt', 'validate' ]"
  echo "  [tf options] - Christ knows 🤷‍♀️"
  echo
  echo "Examples:"
  echo "  ./tf.sh dev eks plan"
  echo "  assume-role sandbox-admin ./tf.sh sandbox vpc plan"
  echo "ENV Variables:"
  echo "  export INFRA_UNIT_DIR='PATH_TO_PROJECT'"
  echo
  1>&2
  exit 1
}

create_state_bucket() {
  aws \
    s3 ls --region $AWS_REGION s3://${AWS_STATE_BUCKET} >/dev/null 2>&1 \
    || aws \
      s3 mb --region $AWS_REGION s3://${AWS_STATE_BUCKET} \
    || (echo "Unable to create bucket ${AWS_STATE_BUCKET}" && usage)
}

enable_bucket_versioning() {
  aws \
    s3api get-bucket-versioning --region $AWS_REGION --bucket ${AWS_STATE_BUCKET} \
    | grep -q Enabled \
    || aws \
      s3api put-bucket-versioning \
      --bucket ${AWS_STATE_BUCKET} \
      --versioning-configuration Status=Enabled \
    || (echo "Bucket versioning not enabled for ${AWS_STATE_BUCKET}" && usage)
}

create_lock_table() {
  aws \
    dynamodb list-tables --region $AWS_REGION | grep -q $AWS_DYNAMODB_TABLE \
    || aws \
      dynamodb create-table \
      --region $AWS_REGION \
      --table-name $AWS_DYNAMODB_TABLE \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
      >/dev/null 2>&1 \
    || (echo "Unable to create $AWS_DYNAMODB_TABLE table" && usage)
}

get_hcl_value(){
  value=$(grep ^$1 $CONFIG_DIR/$ENV/backend-$ENV.tfvars | awk -F= '{print $2}')
  value=${value#*'"'}
  value=${value%'"'*}
  echo "$value"
}
get_hcl_value_env(){
  value=$(grep ^$1 $CONFIG_DIR/$ENV/$ENV.tfvars | awk -F= '{print $2}')
  value=${value#*'"'}
  value=${value%'"'*}
  echo "$value"
}

load_backend_config(){
  AWS_ROLE=$(get_hcl_value_env role_arn_fin)
  AWS_REGION=$(get_hcl_value region)
  AWS_STATE_BUCKET=$(get_hcl_value bucket)
  AWS_DYNAMODB_TABLE=$(get_hcl_value dynamodb_table)
  AWS_ACCOUNT=$(echo -n $AWS_ROLE | awk -F: '{print $5}')
}

get_valid_envs(){
  validEnvs=( $(ls $CONFIG_DIR) )
}

get_valid_infra_units(){
  validInfraUnits=( $(ls $INFRA_UNIT_DIR) )
}

check_valid_env(){
  #Check for valid environment
  get_valid_envs
  supported=false
  for ve in "${validEnvs[@]}"; do
    if [ "$ve" == "$ENV" ]; then
        supported=true
    fi
  done
  if ! $supported; then
    echo "Unsupported environment $ENV, valid options: ${validEnvs[@]}" && exit 1;
  fi
}

check_valid_infra_unit(){
  #Check for valid infra_unit
  get_valid_infra_units
  supported=false
  for ve in "${validInfraUnits[@]}"; do
    if [ "$ve" == "$INFRA_UNIT" ]; then
        supported=true
    fi
  done
  if ! $supported; then
    echo "Unsupported infra-unit $INFRA_UNIT, valid options: ${validInfraUnits[@]}" && exit 1;
  fi
}

ensure_aws_perms(){
  #Ensure we're running against the right AWS account
  account=`aws sts get-caller-identity --output text --query 'Account'`

  echo "$account -- $AWS_ACCOUNT"
  if [ "$account" != "$AWS_ACCOUNT" ] && [ $INFRA_UNIT != "4.3.g-peering-shared" ]; then
    echo "You're operating in the wrong AWS account"
    usage
  fi
}

unset_aws_perms(){
  #Unsetting AWS vars as we want to AWS to assume a role from globally configured crendentials
  awsVars=( AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN )
  unset ${awsVars[@]}
}

init(){
  echo "Using current env INFRA_UNIT_DIR=${INFRA_UNIT_DIR}"

  rm -rf $TF_DATA_DIR
  mkdir -p $TF_PLUGIN_CACHE_DIR
  load_backend_config
  ensure_aws_perms
  create_state_bucket  
  enable_bucket_versioning
  create_lock_table
  if $in_ci; then
    unset_aws_perms
  fi
  echo "cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform init -backend-config=$CONFIG_DIR/$ENV/backend-$ENV.tfvars >> ${INFRA_UNIT_DIR}/${INFRA_UNIT}/terraform_init.log"
  cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform init -backend-config=$CONFIG_DIR/$ENV/backend-$ENV.tfvars 
}
check_object_list(){
  [[ -z $FAST ]] && init
  command="cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform state list | grep -e data -e module -e resource  | grep -v :: | wc -l"
  #echo "Running the following command next:"
  #echo $command
  eval "$command"
}

run_tf(){
  [[ -z $FAST ]] && init
  echo "run_tf"
  command="cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform $ACTION $AUTOAPPROVE $AUTORUN -var-file=$CONFIG_DIR/$ENV/$ENV.tfvars -var-file=$CONFIG_DIR/$ENV/backend-$ENV.tfvars ${EXTRA_ARGS[@]}"
  echo "Running the following command next:"
  echo $command
  eval $command
}

run_state(){
  [[ -z $FAST ]] && init
  command="cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform $ACTION ${EXTRA_ARGS[@]} $AUTOAPPROVE $AUTORUN"
  #echo "Running the following command next:"
  #echo $command
  eval $command
}

run_fmt(){
  init
  command="cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform $ACTION ${EXTRA_ARGS[@]}"
  echo "Running the following command next:"
  echo $command
  eval $command
}

run_custom(){
  #init
  command="cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform ${EXTRA_ARGS[@]}"
  #echo "Running the following command next:"
  #echo $command
  eval $command
}

run_import(){
  init
  command="cd $INFRA_UNIT_DIR/$INFRA_UNIT && TF_PLUGIN_CACHE_DIR=$TF_PLUGIN_CACHE_DIR TF_DATA_DIR=$TF_DATA_DIR terraform import -var-file=$CONFIG_DIR/$ENV/$ENV.tfvars -var-file=$CONFIG_DIR/$ENV/backend-$ENV.tfvars ${EXTRA_ARGS[@]}"
  echo "Running the following command next:"
  echo $command
  eval $command
}

autoapprove(){
  AUTOAPPROVE="-auto-approve"
}

autorun(){
  AUTORUN="-input=false -detailed-exitcode"
}

deletestatebucket(){
  [[ $ENV =~ ^(dev|preprod|prod)$ ]] && ( echo "You can't touch $ENV bucket" && exit 1)
  aws s3 ls s3://wave-tf-state-${ENV} >/dev/null 2>&1 || (echo "Bucket wave-tf-state-${ENV} doesn't exist" && exit 1)
  echo "Bucket exists, checking if state files track any resources..."
  rm -rf tdbd_internal && mkdir -p tdbd_internal && cd tdbd_internal
  aws s3 sync s3://wave-tf-state-${ENV}/ .
  for i in `find . -name '*.tfstate'`; do terraform state list -state $i; done 2>&1 | grep -q '.*' && (echo "Some / all state files track resources, cannot continue." && cd ../ && rm -rf tdbd_internal && exit 1)
  cd ../ && rm -rf tdbd_internal
  echo "State files empty, deleting bucket and all files contained within it."
  aws s3api delete-objects  --bucket wave-tf-state-${ENV} --delete "$(aws s3api list-object-versions --bucket "wave-tf-state-${ENV}" --output=json --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" || echo "Attempted to remove versioned files."
  aws s3api delete-objects  --bucket wave-tf-state-${ENV} --delete "$(aws s3api list-object-versions --bucket "wave-tf-state-${ENV}" --output=json --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')" || echo "Attempted to remove versioned files delete markers."
  aws s3 rb s3://wave-tf-state-${ENV} --force
}


in_ci=false

if [ "$#" -lt 2 ]; then
  echo "ERROR: Wrong number of params!"
  usage
fi

if [ "$ACTION" == "deletestatebucket" ]; then
  echo "Attempting to delete state bucket"
  deletestatebucket
else

  check_valid_env
  check_valid_infra_unit
  case "$ACTION" in
    plan)
      run_tf
      ;;
    apply)
      run_tf
      ;;
    validate)
      run_tf
      ;;
    show)
      run_tf
      ;;
    fmt)
      run_fmt
      ;;
    ciplan)
      ACTION=plan
      autorun
      in_ci=true
      run_tf
      ;;
    ciapply)
      autoapprove
      ACTION=apply
      #in_ci=true
      run_tf
      ;;
    destroy)
      run_tf
      ;;
    cidestroy)
      autoapprove
      ACTION=destroy
      #in_ci=true
      result2="$(check_object_list)"
      result="$(check_object_list | tail -1)"
      if [ $result -ne 0 ]
      then
        run_tf
      else
        echo ":::::: Cache empty"
      fi
      ;;
    refresh)
      run_tf
      ;;
    print)
      tbd
      ;;
    state)
      run_state
      ;;
    custom)
      run_custom
      ;;
    import)
      run_import
      ;;
    *)
      echo "Invalid action $ACTION"
      usage
      ;;
  esac
fi
