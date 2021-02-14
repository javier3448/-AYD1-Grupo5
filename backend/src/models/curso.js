const { Schema, model } = require('mongoose');

const cursoSchema = new Schema({
    nombre: String,
    horainicio: String,
    horafinal: String,
    dias: String,
    catedratico: String
});

module.exports = model('Curso', cursoSchema);