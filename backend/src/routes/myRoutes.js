const { Router } = require('express');
const { Mongoose } = require('mongoose');
const router = Router();
const Estudiante = require('../models/estudiante');



router.post('/login', async (req, res) => {
    const data = req.body;
    const resultado = await Estudiante.findOne({ carne: data.nombre, password: data.contrasena});
    if (resultado == null){
        console.log(err);
        res.status(404);
    }else{
        res.status(202);
        res.json(resultado);
        console.log("crendenciales correctas :3")
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



module.exports = router; 