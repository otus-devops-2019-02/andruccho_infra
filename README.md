# andruccho_infra
andruccho Infra repository

### SSH Tricks
Cпособ подключения к someinternalhost в одну команду
```
ssh -At public.example.com ssh private1.internal
```
Подключение из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost

В файл ~/.ssh/config добавить строки
```
Host someinternalhost
  HostName <bastion_external_ip>
  RequestTTY force
  RemoteCommand ssh <someinternalhost_ip>
  ForwardAgent yes
```
IP addresses for tests
```
bastion_IP = 35.195.91.35
someinternalhost_IP = 10.132.0.7
```

Start instance with startup script 
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
  --metadata-from-file startup-script=startup.sh
```

Add firewall rule
```
gcloud compute firewall-rules create puma-server \
    --action allow \
    --target-tags puma-server \
    --source-ranges 0.0.0.0/0 \
    --rules tcp:9292 \
    --no-disabled
```

Cloud testapp creds for tests
```
testapp_IP = 35.204.120.105
testapp_port = 9292
```

Buld immutable image with app
```
packer validate -var-file variables.json immutable.json
packer build -var-file variables.json immutable.json
```

Deploy with gcloud
```
gcloud compute instances create reddit-app\         
  --boot-disk-size=10GB \
  --image-family reddit-full \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure
```

Добавлен конфиг terraform, который создает инстанс в GCP и деплоит приложение.
```
terraform plan
terraform apply
```

Форматирование .tf файлов
```
terraform fmt
```

Добавили ansible плейбуки для установки пакетов на db и app серверы с вызовом из packer provisioners
```
ansible/playbooks/packer_app.yml
ansible/playbooks/packer_db.yml
```

Добавили ansible плейбук для конфигурирования db и app серверов и деплоя приложения. Добавили окружения stage и prod. Запуск в окружении stage:
```
ansible-playbook playbooks/site.yml
```

Добавили роль из ansible galaxy – установка nginx и сконфигурировали чтобы приложение было доступно на 80 порту.

Добавили роль создания userов с помощью Vault. Для использования Vault на MacOS
```
sudo easy_install pip
pip install passlib
```

Команды Vagrant
```
vagrant up
vagrant status
vagrant ssh appserver
vagrant provision dbserver
vagrant destroy -f
```

Команды Molecule
```
molecule init scenario --scenario-name default -r db -d vagrant
molecule create
molecule list
molecule converge
molecule verify
```

