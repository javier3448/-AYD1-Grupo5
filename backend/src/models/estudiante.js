const { Schema, model } = require('mongoose');

const estudianteSchema = new Schema({
    nombre: String,
    apellido: String,
    CIU: String,
    Carne: String,
    username: String,
    password: String
});

module.exports = model('Estudiante', estudianteSchema);