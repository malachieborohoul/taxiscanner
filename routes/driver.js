const express = require('express');

const driverController = require('../controllers/driver');

const router = express.Router();


//add driver informations
router.get('/hello', driverController.hello);
router.post('/add-driver', driverController.addDriver);
router.post('/save-driver-qrcode', driverController.saveDriverQrCode);
router.post('/id-driver-exist', driverController.isDriverExist);

module.exports = router; 