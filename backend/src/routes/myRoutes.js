const { Router } = require('express');
const { Mongoose } = require('mongoose');
const router = Router();
const Estudiante = require('../models/estudiante');

router.get('/', (req, res) => {
    res.json({'Resultado': 'API AYD1: Grupo 5! :D'});
});

// post simple para hacer pruebas
router.post('/handle',(req, res) => {
    console.log(request.body);
});

router.post('/login', async (req, res) => {

    try {

        const data = req.body;
        await Estudiante.findOne({ carne: data.carne, password: data.password}, function (err, docs) { 
            if (err){ 
                console.log(err)
                res.status(404);
                res.send({ message : error }); 
                console.log("crendenciales incorrectas o usuario no existe :c");
            } else if (docs == null) {
                res.status(404);
                res.send({ message : "crendenciales incorrectas o usuario no existe" }); 
                console.log("crendenciales incorrectas o usuario no existe :c");
            } else{ 
                res.status(202);
                console.log("crendenciales correctas :3")
                res.json(docs);              
            } 
        });
        
    } catch (error) {
        console.log(error)
        res.status(404);
        res.send({ message : error });
        console.log("crendenciales incorrectas o usuario no existe :c");
    }

});

router.post("/create", async (req, res) => {
    try {

        const data = req.body;            
        await Estudiante.create({
            nombre: data.nombre,
            apellido: data.apellido,
            CUI: data.CUI,
            carne: data.carne,
            username: data.username,
            password: data.password
        }); 
        res.status(202);
        res.json({ message : 'Estudiante registrado'});

    } catch (error) {
        console.log(error)
        res.status(404);
        res.send({ message : error });
    }
});

router.post("/new", async (req, res) => {
    
    const data = req.body;  

    Estudiante.exists({ CUI: data.CUI }, async function (err, doc) { 
        if (err){ 
            console.log(err)
            res.status(404);
        }else{ 
            if (!doc){

                Estudiante.exists({ carne: data.carne }, async function (err2, doc2) { 
                    if (err2){ 
                        console.log(err2)
                        res.status(404);
                    }else{ 
                        if (!doc2){

                            Estudiante.exists({ username: data.username }, async function (err3, doc3) { 
                                if (err3){ 
                                    console.log(err3)
                                    res.status(404);
                                }else{ 
                                    if (!doc3){

                                        await Estudiante.create({
                                            nombre: data.nombre,
                                            apellido: data.apellido,
                                            CUI: data.CUI,
                                            carne: data.carne,
                                            username: data.username,
                                            password: data.password
                                        }); 
                                        res.status(202);
                                        res.json({ message : 'Estudiante registrado :)'});
                                      
                                    } else {
                                        res.status(404);
                                        res.json({ message : 'Estudiante ya existente :('});
                                    }
                                } 
                            }); 
                          
                        } else {
                            res.status(404);
                            res.json({ message : 'Estudiante ya existente :('});
                        }
                    } 
                }); 

              
            } else {
                res.status(404);
                res.json({ message : 'Estudiante ya existente :('});
            }
        } 
    }); 
  
});

router.post("/update", async (req, res) => {

    try {

        const data = req.body;

        await Estudiante.findOneAndUpdate({ CUI: data.CUI, carne: data.carne, username: data.username},
                {
                nombre: data.nombre,
                apellido: data.apellido,
                CUI: data.CUI,
                carne: data.carne,
                username: data.username,
                password: data.password},(err, doc) => {
                    if (err){
                        console.log(error)
                        res.status(404);
                        res.send({ message : error });
                    } else {
                        res.status(202);
                        res.json({ message : 'Datos del estudiante actualizados :D'}); 
                    }
                }
            );
        
    } catch (error) {
        console.log(error)
        res.status(404);
        res.send({ message : error });
    }

});

module.exports = router; 