const express = require('express');

const mongoose = require('mongoose');

const driverRoute = require('./routes/driver')


const app = express();

const Driver = require('./models/driver');
const PORT = process.env.PORT || 3000;

app.use(express.json())
app.use(driverRoute);


mongoose.connect("mongodb+srv://bsm:mX80T67cpFEVng0g@cluster0.kyqpo0c.mongodb.net/?retryWrites=true&w=majority").then((result)=>{
    console.log('Connected');
    app.listen(PORT,"0.0.0.0", ()=>{
        console.log(`Server running on port ${PORT}`)
    });
}).catch((err)=>{
    console.log(err);
})

