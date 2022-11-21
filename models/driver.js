const mongoose = require('mongoose');

const Schema = mongoose.Schema;
const driverSchema = new Schema({
    nom:{
        type: String,
        required: true 
    },
    prenom:{
        type: String,
        required: true
    },
    codeChauffeur:{
        type: String,
        required: true
    },
    numeroIm:{
        type: String,
        required: true
    },

    photo:{
        type: String,
        required: true
    }, 

    qrImage:{
        type: String
    }
});

module.exports = mongoose.model('Driver',driverSchema );