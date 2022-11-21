
const Driver = require("../models/driver");
exports.addDriver = (req, res, next) => {

    const {nom, prenom, codeChauffeur, numeroIm, photo}=req.body;
//   const nom = "req.body.nom";
//   const prenom = "req.body.prenom";
//   const codeChauffeur = "req.body.codeChauffeur";
//   const numeroIm =" req.body.numeroIm";

  const driver = new Driver({
    nom,
    prenom,
    codeChauffeur,
    numeroIm,
    photo
  }); 

  driver 
    .save()
    .then((result) => {
      console.log("Driver added");
      res.json(driver['id'])
    })
    .catch((err) => {
      console.log(err);

    });
};

exports.hello=(req, res)=>{
    // const {nom} = req.body;
    res.send("hello") 
};


exports.saveDriverQrCode= (req, res)=>{
  const {idDriver,qrImage } = req.body;

  Driver.findById(idDriver).then((driver)=>{
    if(!driver){
      return res.json("No driver");
    }
    driver.qrImage= qrImage;
    return driver.save();
  })
  .then((result)=>{
    res.json(result);
    console.log("QrCode Driver added");
  })
  
  .catch((err)=>{
    console.log(err)
  })
};

exports.isDriverExist = (req, res)=>{
  const {idDriver} = req.body;

  Driver.findById(idDriver).then((driver)=>{
    if(!driver){
      return res.json(false);
    }

     res.json(driver);
  }).catch((err)=>{
    return res.json(false);
    console.log(err);
  })
}
