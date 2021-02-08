const { Router } = require('express');
const router = Router();


router.get('/api/login', (req, res) => {
    res.json({'Resultado': 'Endpoint para el login! :D'});
});




module.exports = router; 