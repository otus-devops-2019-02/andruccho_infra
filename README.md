# andruccho_infra
andruccho Infra repository

Cпособ подключения к someinternalhost в одну команду

ssh -At public.example.com ssh private1.internal

Подключение из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost

В файл ~/.ssh/config добавить строки

Host someinternalhost
  HostName <bastion_external_ip>
  RequestTTY force
  RemoteCommand ssh <someinternalhost_ip>
  ForwardAgent yes



