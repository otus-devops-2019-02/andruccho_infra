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
bastion_IP = 34.76.216.139
someinternalhost_IP = 10.132.0.7
```
