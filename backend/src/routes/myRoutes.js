const { Router } = require('express');
const router = Router();
const Estudiante = require('../models/estudiante');



router.get('/api/login', (req, res) => {
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
        console.log(data);
        res.json({ message : 'Estudiante registrado'});

    } catch (error) {
        console.log(error)
        res.send({ message : error });
    }
});


module.exports = router; 