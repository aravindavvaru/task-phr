# task-phr
## Tasks
### Prepare the server
* Create user `phrase_admin` without password capable to `sudo` without password, remote access via public key `phrase_admin.pub` should be allowed
* Create user `phrase_user` without any extra permissions, remote access via oublic key `phrase_user.pub` should be allowed
* Install basic packages like `curl`, `jq` and editor of your liking

### Dockerize the application
* Build the docker image of the application
* Prepare the DB (postgresql, mysql or mariadb) for the application with 2 users one user with full access for application and second  read-only user `developer`
* Start 2 containers with the REST application 
* Deploy redis container and interconnect application containers with it (Pending)
* The containers should start/restart automatically unless the container is stopped

- terraform for provisioning the server
    - Server from cloud
    - Vagrant for local server provisioning
- ansible for configuring the server
    - roles to configure each task
        - common, dockerize_application, k8s_cluster, loadbalancing_ssl

        ├── common
    │   ├── files
    │   │   ├── phrase_admin.pub
    │   │   └── phrase_user.pub
    │   └── tasks
    │       └── main.yml
    ├── dockerize_application
    │   ├── files
    │   │   └── config.json
    │   └── tasks
    │       └── main.yml
    ├── k8s_cluster
    │   ├── README.md
    │   ├── defaults
    │   │   └── main.yml
    │   ├── files
    │   │   ├── charts
    │   │   │   ├── app
    │   │   │   │   ├── Chart.yaml
    │   │   │   │   ├── templates
    │   │   │   │   │   ├── _helpers.tpl
    │   │   │   │   │   ├── phrase.yaml
    │   │   │   │   │   └── statefulset.yaml
    │   │   │   │   └── values.yaml
    │   │   │   ├── postgres
    │   │   │   │   ├── Chart.yaml
    │   │   │   │   ├── templates
    │   │   │   │   │   ├── _helpers.tpl
    │   │   │   │   │   ├── postgres-configmap.yml
    │   │   │   │   │   ├── postgres-deployment.yml
    │   │   │   │   │   ├── postgres-storage.yml
    │   │   │   │   │   └── postgres-svc.yml
    │   │   │   │   └── values.yaml
    │   │   │   └── redis
    │   │   │       ├── Chart.yaml
    │   │   │       ├── templates
    │   │   │       │   ├── _helpers.tpl
    │   │   │       │   ├── configmap.yml
    │   │   │       │   └── pod.yml
    │   │   │       └── values.yaml
    │   │   ├── cluster.sh
    │   │   └── config.yaml
    │   └── tasks
    │       └── main.yml
    └── loadbalancing_ssl
        ├── README.md
        ├── defaults
        │   └── main.yml
        ├── files
        │   ├── ingress.sh
        │   ├── ingress.yml
        │   └── phrase-nginx
        ├── handlers
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        └── vars
            └── main.yml

### Loadbalancing and SSL
* Place the containers behind load balancer and balance traffic between them 
* Everything should be available via HTTPS, HTTP should be automatically redirected to the HTTPS. Use self-signed or let's encrypt SSL certificate. (reverse_proxy)
* `/admin` endpoint is behind basic auth protection, create one user `developer` with some password
* `/prepare-for-deploy` and `/ready-for-deploy` endpoint are blocked on load balancer and not available from the internet

### Deployment script
Prepare the script we can use for release new version of the application, use any reasonable framework, tooling, language or shell environment
- Makefile to automate the entire workflow