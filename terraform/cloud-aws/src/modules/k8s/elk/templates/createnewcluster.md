# Requirements
Download last version all-in-one:
https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html

```bash
kubectl apply -f https://download.elastic.co/downloads/eck/1.0.1/all-in-one.yaml
```

# Procedure
## 1. Install elastic-Elasticsearch

```bash
kubectl apply -f elastic-search.yaml
```

## 2. Obtain Password 
- (should wait until elasticsearch object will be completely created similar to the following table)

```bash
SKMOSXHJ64JG5HP:elkv2 c0261687$ kubectl get elasticsearch -n devops-ns
NAME      HEALTH   NODES   VERSION   PHASE   AGE
elastic   green    2       7.6.1     Ready   131m
```

- Command to get the password of elasticsearch user

```bash
PASSWORD=$(kubectl get secret elastic-es-elastic-user --namespace devops-ns -o=jsonpath='{.data.elastic}' | base64 --decode)
```

- Inside the pod or having connection with the internal IP, test the connection:

```bash
curl -u "elastic:$PASSWORD" -k "https://elastic-es-http:9200"
```

## 3. Create kibana

```bash
kubectl apply -f kibana.yaml
```

## 4. Create apm

- Create a new secret with the password
```bash
kubectl create secret generic apm-secret-settings -n devops-ns --from-literal=ES_PASSWORD=$PASSWORD
```

- Apply the apm yaml configuration
```bash
kubectl apply -f apm.yaml
```


## 5. Create ingress

```bash
kubectl apply -f ingress.yaml
```

## 6. Config cluster Filebeat

Modify yalm file with the correct environment files.
```bash
kubectl apply -f filebeat-kubernetes.yaml
```

## 7. Configure Snapshot
### 7.1 Configure azure repository credentials

- Connect to elasticsearch pods.
```bash
kubectl exec -it pod_name -n devops-ns bash
```

- For each pod execute the following command
```bash
bin/elasticsearch-keystore add azure.client.default.account
Enter value for azure.client.default.account: $AZURE_STORAGE_ACCOUNT_NAME
```
```bash
bin/elasticsearch-keystore add azure.client.default.key Enter value for azure.client.default.key: $AZURE_STORAGE_ACCOUNT_KEY
```
- Execute the following command from kibana devTools 
```bash
POST _nodes/reload_secure_settings 
```

  ![Kibana_reload_configuration](./png/reloadConfiguration.png)

or 

```bash
curl -X POST "elastic-es-http.devops-ns:9200/_nodes/reload_secure_settings?pretty"
```


### 7.2 Register repository

  ![Kibana_register_repository](./png/registerRepository.png)

- Check blob storage connection

  ![Kibana_check_blob_storage_connection](./png/checkBlobStorageConnection.png)


### 7.3 Create snapshot Policy

  ![Kibana_snapshot_policy](./png/snapshotPolicy.png)
