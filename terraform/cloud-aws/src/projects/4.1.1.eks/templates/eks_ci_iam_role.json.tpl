{
  "Version": "2012-10-17",
  "Statement": [
     {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::909517579108:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "BoolIfExists": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    },
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": [
          "${circleci_instance_profile_role}",
          "${circleci_nomad_instance_profile_role}"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
