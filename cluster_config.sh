#!/bin/bash

gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 60 --margin "1 2" --padding "2 4" \
    'Bienvenido a la configuración del clúster Burrotrón, enfocado en desarrollo e investigación de Inteligencia Artificial de la UPIIZ-IPN' \
    'Feedback y soporte: @upiiz-ia en github'

# Utilizar gum para seleccionar qué configurar
select_option=$(gum choose --header "¿Qué deseas configurar?" "Master" "Nodo" "Salir")

# Configurar según la opción seleccionada
if [ "$select_option" = "Master" ]; then
    # Instalar k3s en el nodo maestro
    echo "Instalando k3s en el nodo maestro..."
    if ! curl -sfL https://get.k3s.io | sh -; then
        echo "Error: No se pudo instalar k3s en el nodo maestro."
        exit 1
    fi

    # Generar token para los nodos trabajadores
    echo "Generando token para los nodos trabajadores..."
    if ! k3s token create; then
        echo "Error: No se pudo generar token para los nodos trabajadores."
        exit 1
    fi

    # Configurar kubeconfig
    echo "Configurando kubeconfig..."
    if ! k3s kubectl config view --flatten > ~/.kube/config; then
        echo "Error: No se pudo configurar kubeconfig."
        exit 1
    fi

    # Verificar estado de los nodos
    echo "Verificando estado de los nodos..."
    if ! k3s kubectl get nodes; then
        echo "Error: No se pudo verificar estado de los nodos."
        exit 1
    fi
    echo "Master configurado correctamente"
    elif [ "$select_option" = "Nodo" ]; then
    # Pedir al usuario el número de nodo
    read -p "Ingrese el número de nodo: " NODE_NUMBER

    # Establecer hostname para el nodo
    echo "Estableciendo hostname para el nodo..."
    if ! sudo hostnamectl set-hostname nodo$NODE_NUMBER; then
        echo "Error: No se pudo establecer hostname para el nodo."
        exit 1
    fi

    # Pedir al usuario el token del nodo maestro
    read -p "Ingrese el token del nodo maestro: " TOKEN

    # Pedir al usuario la dirección IP del nodo maestro
    read -p "Ingrese la dirección IP del nodo maestro: " MASTER_NODE_IP

    # Instalar k3s en el nodo
    echo "Instalando k3s en el nodo..."
    if ! curl -sfL https://get.k3s.io | sh -; then
        echo "Error: No se pudo instalar k3s en el nodo."
        exit 1
    fi

    # Unir el nodo al clúster
    echo "Uniendo el nodo al clúster..."
    if ! k3s agent --server https://$MASTER_NODE_IP:6443 --token $TOKEN; then
        echo "Error: No se pudo unir el nodo al clúster."
        exit 1
    fi
    else
    if [ "$select_option" = "Salir" ]; then
        echo "Saliendo del script..."
        exit 0
    fi
fi