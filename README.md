1) Configurar Hosts


2) Criar VMs
vagrant up
vagrant status

3) Permissoes para Chaves SSH
setup.sh
run.sh

4) Validar Processo GeoServer
vagrant ssh
systemctl status geoserverprimary.service
systemctl stop geoserverprimary.service
systemctl start geoserverprimary.service
journalctl -u geoserverprimary.service -f

5) Gerar chaves para sincronizar DATA_DIR

Navegar para pasta `keys/rsync`, e criar chave sincronizar dados entre os servidores.
O nome da chave deve ser `rsync_key e rsync_key.pub`.


sh
```
ssh-keygen -t rsa -b 2048
```
