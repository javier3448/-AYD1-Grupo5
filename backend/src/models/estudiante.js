const { Schema, model } = require('mongoose');

const estudianteSchema = new Schema({
    nombre: { type : String , required : true},
    apellido: { type : String , required : true},
    CUI: { type : String , unique : true, required : true},
    carne: { type : String , unique : true, required : true},
    username: { type : String , unique : true, required : true},
    password: { type : String , required : true},
    cursos: [{  cursoid: String,
                nombre: String,
                codigo: Number,
                seccion: String,
                horainicio: String,
                horafinal: String,
                lunes: String,
                martes: String,
                miercoles: String,
                jueves: String,
                viernes: String,
                sabado: String,
                domingo: String
             }]
});

module.exports = model('Estudiante', estudianteSchema);