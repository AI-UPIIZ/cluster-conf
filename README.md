# Configuración de Burrotrón

Configuración de clúster k3s para proyectos de investigación en Inteligencia Artificial en la UPIIZ-IPN.

## Descripción

Este repositorio contiene los scripts y configuraciones necesarias para crear un clúster k3s en la UPIIZ-IPN, destinado a apoyar el desarrollo de proyectos de investigación en Inteligencia Artificial. El clúster se compone de un nodo maestro y varios nodos trabajadores, y está diseñado para proporcionar un entorno de desarrollo y pruebas escalable y flexible para los proyectos de investigación.

## Requisitos

- k3s versión 1.20 o superior
- Linux Mint o distribución similar
- Acceso a Internet para descargar paquetes y dependencias
- gum instalado en el sistema


## Instalación de gum

Para instalar gum, puedes seguir los siguientes pasos:

```bash
sudo apt-get update
sudo apt-get install gum
```


## Instalación del clúster

Clona el repositorio en tu máquina local. Ejecuta el siguiente comando para iniciar el proceso de instalación:
```bash
sh cluster_config.sh
```
Sigue las instrucciones en pantalla para configurar el clúster.


## Uso

Una vez configurado el clúster, puedes utilizar `kubectl` para gestionar los nodos.
Puedes utilizar el comando `k3s kubectl get nodes` para verificar el estado de los nodos.
