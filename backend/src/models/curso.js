const { Schema, model } = require('mongoose');

const cursoSchema = new Schema({
    nombre: { type : String , required : true},
    codigo: { type : Number , required : true},
    seccion: { type : String , required : true},
    horainicio: { type : String , required : true},
    horafinal: { type : String , required : true},
    catedratico: { type : String , required : true},
    lunes: { type : String , required : true},
    martes: { type : String , required : true},
    miercoles: { type : String , required : true},
    jueves: { type : String , required : true},
    viernes: { type : String , required : true},
    sabado: { type : String , required : true},
    domingo: { type : String , required : true},
    cursos: [{ id: String }]
});

module.exports = model('Curso', cursoSchema);