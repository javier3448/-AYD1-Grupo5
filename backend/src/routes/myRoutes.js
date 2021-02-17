const { Router } = require('express');
const router = Router();
const Estudiante = require('../models/estudiante');



router.post('/login', (req, res) => {
    const data = req.body;
    const resultado = Estudiante.find({carne: data.nombre, password: data.constrasena});
    print (resultado);
    res.json({'Resultado': 'Endpoint para el login! :D'});
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