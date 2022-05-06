# Sobre o Projeto

## Aplicação

Nesse projeto será realizado o deploy do Bookinfo, aplicação que traz informações sobre um livro, suas avaliações e notas. A aplicação é composta por 4 microserviços:

* ``` productpage ```: chama os microserviços ``` reviews ``` e ``` details ``` para alimentar a página.
* ``` details ```: exibe as informações do livro.
* ``` reviews ```: exibe as avaliações do livro e chama o microserviço ``` ratings ```.
* ``` ratings ```: exibe a nota do livro.

O ``` ratings ``` possui 3 versões que estão gerenciadas da seguinte forma:

* ``` ratings-v1 ```: É solicitado quando não existe usuário logado na aplicação - não chama o ``` ratings ``` (sem estrelas).
* ``` ratings-v2 ```: É solicitado quando o usuário logado é igual a <b>ted</b> (estrelas pretas).
* ``` ratings-v3 ```: É solicitado quando o usuário logado é igual a <b>bill</b> (estrelas vermelhas).

## Tecnologias

Tecnologias e ferramentas utilizadas no desenvolvimento do projeto:

* [Kubernetes](https://kubernetes.io/pt-br/): Responsável por implantar e gerenciar o cluster que contém os hosts da aplicação que realizaremos o deploy.
* [Istio](https://istio.io/): Service mesh que facilita o gerenciamento de políticas, tráfego, recursos e comunicação entre diversos microserviços de uma aplicação. O Istio cria um data plane que interliga e controla a comunicação entre os serviços através de proxies. Essa arquitetura é bastante interessante pois permite, por exemplo, a criação de regras de gerenciamento de tráfego por fora da aplicação, já que isso será controlado via proxy. Por conta dessa estrutura, o Istio possibilita o uso de um serviço de telemetria que gera métricas, logs e rastreamento a partir do tráfego da aplicação. Nesse projeto utilizaremos o Kiali, Grafana e Prometheus como ferramentas para monitorar esses dados em tempo real. Além disso, o Istio foi utilizado para criar um ingress que permite acessar a aplicação fora do cluster.
* [Envoy](https://www.envoyproxy.io/): Serviço de proxy utilizado junto ao Istio para gerar os proxies e o rate limit (limitação de requests por segundo para cada serviço).
* [Kiali](https://kiali.io/): É um pacote que permite a visualização gráfica em tempo real de toda a estrutura do service mesh. O Kiali identifica possíveis erros e informa onde se encontra o ponto de falha, o que é muito proveitoso principalmente ao se tratar de grandes arquiteturas. Além disso, essa ferramenta permite realizar alguns testes como o Fault Injection, do qual ocasiona uma falha intencional em um serviço para verificar como a aplicação reage nesse cenário, permitindo mais uma vez encontrar melhorias para o mesh. Nesse projeto o Kiali também foi utilizado como gestor de logs.
* [Grafana](https://grafana.com/): Permite a criação de dashboards dinâmicos para a exibição de gráficos em tempo real. Algumas dashboards são pré-configuradas pelo Istio.
* [Prometheus](https://prometheus.io/): Serviço de monitoramento que obtém os dados da saúde do service mesh e integra-os ao Kiali e Grafana.

## Pré-requisitos

Ferramentas necessárias para o deploy do projeto:

* SO Linux
* K3d - https://k3d.io/v5.4.1/
* Docker - https://docs.docker.com/get-docker/
* Kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

# Realizando deploy da aplicação

## Configuração de aliases para manipulação do kubernetes

Para facilitar a manipulação do kubernetes, vamos criar alguns alias do kubectl para utilizar no terminal do Linux.

1- Adicione o arquivo ao diretório /home/

``` sudo cp .kubectl_aliases ~/ ```

2- Escreva o comando para adicionar o arquivo à lista de alias:

``` source .bashrc ```

3- Liste os alias com o comando:

``` alias ```

## Inicializando cluster

1- Após instalar o k3d, incialize o cluster com o comando abaixo:

``` k3d cluster create <nome-do-cluster> ```

2- Adicione este repositório na sua máquina e dê a permissão para executar os scripts com:

``` chmod +x istio-install.sh ```
``` chmod +x deploy.sh ```
``` chmod +x dashboard.sh ```

3- Na pasta do repositório, execute via terminal o script abaixo para fazer o download, instalar e configurar o Istio:

``` source istio-install.sh ```

4- Na pasta do repositório, execute via terminal o script abaixo para realizar o deploy da aplicação:

``` source deploy.sh ```

Após a inicialização dos pods a aplicação estará disponível na URL exibida e aberta no navegador.

5- Verifique o andamento da criação dos pods com os comandos:

``` kgpo ```

``` kgpo -n istio-system ```

## Utilizando ferramentas de monitoramento

1- Para acessar as ferramentas de monitoramento, execute o script no terminal:

``` source dashboard.sh ```

2- Entre com o número da dashboard desejada, sendo 1- Grafana, 2- Kiali e 3- Prometheus.




