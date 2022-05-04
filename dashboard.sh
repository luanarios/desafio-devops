#!/bin/bash

main ()
{
    echo -e "*** Escolha a aplicação de monitoramento ***\n"
    echo -e "1-Grafana \n2-Kiali \n3-Prometheus\n"
    read opcao;
    case $opcao in
        "1")
        grafana
        ;;
        "2")
        kiali
        ;;
        "3")
        prometheus
        ;;
    esac
}
grafana()
{
    echo "*** Iniciando dashboard Grafana ***"
    istioctl dashboard grafana
}
kiali()
{
    echo "*** Iniciando dashboard Kiali ***"
    istioctl dashboard kiali
}
prometheus()
{
    echo "*** Iniciando dashboard Prometheus ***"
    istioctl dashboard prometheus
}

main
