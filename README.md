# Validação do Datadog Agent no Red Hat Enterprise Linux 10

![Datadog](https://img.shields.io/badge/Datadog-Agent%20v7-632ca6)
![RHEL](https://img.shields.io/badge/RHEL-10-red)

##  Overview

Este repositório contém os recursos necessários para construir uma imagem Docker baseada na imagem UBI do **Red Hat Enterprise Linux 10**. O objetivo principal é instalar e executar a versão mais recente do Datadog Agent para validar sua compatibilidade e funcionamento nesta nova versão do sistema operacional.

O ambiente em contêiner garante um teste limpo, isolado e 100% reprodutível.

##  Objetivo

O propósito deste projeto é verificar o seguinte:

-    **Instalação:** Confirmar que o script de instalação oficial do Datadog Agent funciona sem erros no RHEL 10.

##  Disponível neste Repo

-   `Dockerfile`: Define os passos para construir a imagem Docker com o RHEL 10 e o Datadog Agent.
-   `entrypoint.sh`: Um script simples que inicia o Datadog Agent e um processo simulado em background para manter o contêiner ativo.

##  Pré-requisitos

Antes de começar, você precisará ter:

1.  **Docker** instalado e em execução na sua máquina.
2.  Uma **conta no Datadog**.
3.  Sua **Chave de API (API Key)** do Datadog. Você pode encontrá-la em **Integrations > APIs**.

##  Como Usar

Siga os passos abaixo para construir e executar o ambiente de teste.

### 1. Clone o Repositório

```bash
git clone https://github.com/NSantos6/rhel10-datadog.git
cd rhel10-datadog
```

### 2. Faça o Build da Imagem

Durante o processo de build, você deve passar sua chave de API do Datadog de forma segura usando um `build-arg`. Substitua `<SUA_CHAVE_API>` pela sua chave real.

```bash
docker build \
  --build-arg DD_API_KEY="<SUA_CHAVE_API>" \
  -t rhel10-dd-agent-test .
```

O `Dockerfile` está configurado para usar a sua chave durante a instalação e configurar o Agent automaticamente.

### 3. Execute o Contêiner

Após o build ser concluído com sucesso, inicie o contêiner em background.

```bash
docker run -d --name rhel10-test rhel10-dd-agent-test
```

##  Validação

Após iniciar o contêiner, siga estes passos para validar que o Agent está funcionando.

### 1. Verifique os Logs do Agent

Você pode checar o status do Agent diretamente pelos logs do contêiner.

```bash
# Espere alguns segundos para o Agent iniciar e depois execute:
docker logs -f rhel10-test
```

Você também pode executar o comando de status dentro do contêiner:

```bash
docker exec rhel10-test agent status
```

### 2. Verifique no Datadog

O resultado é ver o novo host aparecendo na sua conta Datadog.

1.  Acesse sua conta Datadog.
2.  Navegue até a seção **Infrastructure > Infrastructure List**.
3.  Procure por um host com o nome `meu-host-rhel10` (este nome foi definido via variável de ambiente `DD_HOSTNAME` no `Dockerfile` para evitar erros).
4.  Clique no host para ver as métricas de sistema, processos e outros dados que estão sendo coletados.

##  Resultados Esperados

Se o teste for bem-sucedido, o host `meu-host-rhel10` aparecerá na sua lista de infraestrutura no Datadog, reportando métricas ativamente e sem apresentar erros nos logs do Agent. Isso valida que a versão mais recente do Datadog Agent é compatível com o RHEL 10.

##  Links úteis

Repositório YUM datadog-agent: [Datadog YUM](https://yum.datadoghq.com/stable/7/x86_64/)

Repositório APT datadog-agent: [Datadog APT](https://apt.datadoghq.com/)

## Script instalação Agent v7 
![Datadog](https://img.shields.io/badge/Datadog-Agent%20v7-632ca6)
```bash
bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
```
