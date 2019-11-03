# Automated deployment with Ansible
Automated dockerized Nginx/Postgres/Django/Vue/ stack deployment
 
## Pre-requisites and setup
* Fresh web Server (Preferably Debian OS). RECOMMEND: 2GB RAM / 20GB SSD 
* Point your DNS domain name to your server
* Modify hosts.ini and group_vars settings appropriately (see settings section)
* Drop any .env file your apps may require into the home directory
* Ensure the server has access to you private docker registry if necessary
* Non root user with sudo privileges (no password), default is admin

## Settings
### Project settings
```yaml
TEMP_DIR: "{{ ansible_env.HOME }}/tmp" # Directory for temporary deploy files
LETSENCRYPT_EMAIL: you@example.com
HOME_DIR: /home/admin # Home directory of a non root user with 
DOCKER_REGISTRY: private.registry.url
PROJECT_NAME: your-project-name
DOMAIN_NAME: example.com
LOCAL_POSTGRES: FALSE/TRUE # Incorporate postgres into the docker-compose stack in lei of a remote db
```
### Database settings
```yaml
POSTGRES_HOST: localhost
POSTGRES_PORT: 5432
POSTGRES_IP_HOST: "0.0.0.0"
POSTGRES_DB: db_name
POSTGRES_USER: db_user
POSTGRES_PASSWORD: !vault | XXXX # Never store this in plain text if you commit to version control
```

## Usage
**!!Important!!** Make sure you have ssh access to the remote server as well as Ansible installed on the host
you wish to deploy from.

Run a playbook (where your-host is the host server and playbook.yml is the playbook:
```shell script
ansible-playbook -i hosts.ini --extra-vars="target=your-host" playbook.yml
```
### Playbooks
**provision_db.yml** Provision a remote database for your project

**provision_host.yml** Once off command to install docker, get letsencrypt certificates, and copy configuration files.

**reinitialize_project.yml** Redeploy configuration files and restart docker. This is necessary if you alter any
of the configuration templates in the ansible role `initialize_project`






