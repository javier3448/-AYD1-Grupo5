#!bash

# ESTE SCRIPT NO FUNCION (talvez) SI HACEMOS CAMBIOS EN EL REPO LOCAL DEL SERVIDOR
# Y QUEREMOS QUE ESOS CAMBIOS SE VEAN REFLEJADOS AL LEVANTAR NUEVAMENTE EL SERVIDOR
# Si quisieramos hacer eso:
# 1. Hacer los cambios
# 2. Reiniciar el proceso del servidor `pm2 delete all` , `pm2 start "direccion del index.js"`
# 3. Si queremos subir los cambios al repo remote tenien que hacerlo como harien cualquier
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

# @TODO: Agregar opcion para que use la rama deployment/release

branch="main"
if [[ $# -ne 0 ]] ; then
	branch=$1
fi

pm2 delete all

git restore .

# Otra opcion:
# git stash save --keep-index --include-untracked
# git stash drop

git pull --all

git checkout branch

npm install ./backend

pm2 start ./backend/src/index.js