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
