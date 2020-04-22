# Configuração Inicial do GeoServer

### 1) Configurar hosts
Adicionar nos arquivos `hosts_hmg` e `hosts_prd` os IPs e usuários das chaves SSH dos respectivos servidores. Ambas as máquinas serão acessíveis pela porta 80 (HTTP) e 22 (SSH).



**Observação:**

No ambiente de produção, a máquina com maior recurso é a `geoserversecundary`. A aplicação irá consultar o WMS desta máquina. 

A `geoserversecundary` possui uma replica do `DATA_DIR` da `geoserverprimary` (maquina usada para configuração e geração de cache), e com isso deve ter acesso SSH a `geoserverprimary` para o job de sincronização do `DATA_DIR`. 



**1.1) Configurar variáveis para sincronizar dados via SSH com Rsync**

No arquivo de variáveis para o `geoserversecundary` é necessário adicionar o IP do host `geoserverprimary`, além do usuário e senha dos GeoServers. Esse processo é necessário para que o Rsync consiga realizar a sincronização do `DATA_DIR` via SSH, e recarregar os metadados dos layers do `geoserversecundary`.



O arquivo a ser editado esta na pasta:

* `group_vars/geoserversecundary.yml`



Exemplo:

```yml
primary_geoserver_host_ip: 192.168.99.99
secundary_geoserver_user: admin
secundary_geoserver_password: geoserver
```




### 2) Chaves SSH
**Copiar as chaves SSH privada de produção das máquinas para os respectivos diretórios:**

* `keys/geoserverprimary` com o nome de `private_key`
* `keys/geoserversecundary` com o nome de `private_key`



**Criar chave SSH para sincronizar `DATA_DIR` de produção** 

Navegar para pasta `keys/rsync`, e criar chave sincronizar dados entre os servidores. O nome da chave deve ser `rsync_key e rsync_key.pub`. **A chave não deve possuir senha.**

```sh
ssh-keygen -t rsa -b 2048
```



**Copiar as chaves SSH privada de homologação da máquina para o respectivo diretório:**

* `keys/geoserversingle` com o nome de `private_key`



**No final, ficará a seguinte configuração:**

* `keys/geoserverprimary/private_key`
* `keys/geoserversecundary/private_key`
* `keys/rsync/rsync_key`
* `keys/rsync/rsync_key.pub`
* `keys/geoserversingle/private_key`



### 3) Alterar permissões das chaves SSH

Pode ser necessário alterar as permissões das chaves para executar o `ansible`. Desta forma, existe um script para auxiliar com isto:

```bash
#!/bin/sh

chmod -R go= ./keys
ssh-keygen -R <TROCAR PELO IP>

```



### 4) Executar playbook ansible no ambiente de homologação

Caso não possua ansible instalado, configurar com os comandos abaixo (sistemas baseados em Debian):

```sh
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt update
$ sudo apt install ansible
```



Executar playbook com o comando:

```sh
$ sh run_hmg.sh
```



### 5) Executar playbook ansbile no ambiente de produção

```sh
$ sh run_prd.sh
```

