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


