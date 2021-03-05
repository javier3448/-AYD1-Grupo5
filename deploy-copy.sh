#!/bin/bash

# PARA CORRER ESTE SCRIPT TIENEN QUE PONERLO EN LA MISMA CARPETA EN LA QUE ESTA EL
# REPO, NO EN LA CARPETA DEL REPO COMO TAL. Tengo una copia del script adentro del
# repo solo para que tenga control de versiones tambien

# ESTE SCRIPT NO FUNCIONA (talvez) SI HACEMOS CAMBIOS EN EL REPO LOCAL DEL SERVIDOR
# Y QUEREMOS QUE ESOS CAMBIOS SE VEAN REFLEJADOS AL LEVANTAR NUEVAMENTE EL SERVIDOR
# Si quisieramos hacer eso:
# 1. Hacer los cambios
# 2. Reiniciar el proceso del servidor `pm2 delete all` , `pm2 start "direccion del index.js"`
# 3. Si queremos subir los cambios al repo remote tenien que hacerlo como harian cualquier
#    otro commit desde su maquina local
# Recomendaria tratar de hacer los cambios localmente en sus maquinas, subirlos 
# al github y luego correr este script, a menos que eso sea demasiado tardado e 
# incomodo. 

# Si cambian las siguientes rutas (relativas a donde esta este script):
# ./backend/package.json
# ./backend/package-lock.json
# ./backend/src/index.js
# Me tienen que avisar para que pueda actualizar el script

# Cualquier duda, o si algo no funciona como esperan, me pueden llamar 
# -Javier

branch="main"
if [[ $# -ne 0 ]] ; then
	branch=$1
fi

pm2 delete all
pm2 flush

rm -rf ./-AYD1-Grupo5

# Creo que solo funciona si el repo es publico
git clone https://github.com/javier3448/-AYD1-Grupo5.git

git --git-dir ./-AYD1-Grupo5/.git checkout develop

npm install --prefix ./-AYD1-Grupo5/backend ./-AYD1-Grupo5/backend

pm2 start ./-AYD1-Grupo5/backend/src/index.js --time

# comando ad hoc para tronarse el proceso de node si lo corremos a mano
# kill `ps aux | grep node | grep -v "grep" | awk '{print $2}'`