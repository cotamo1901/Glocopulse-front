const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 5000;
const jwtSecret = process.env.JWT_SECRET || "nose"

// Middlewares
app.use(cors());
app.use(express.json());

// Conexión a MongoDB
const mongoURI = process.env.MONGO_URI;
mongoose.connect(mongoURI)

  .then(() => console.log("MongoDB conectado"))
  .catch(err => console.error("Error al conectar a MongoDB:", err));

// Modelo de usuario
const Usuarios = mongoose.model("Usuarios", new mongoose.Schema({
  nombre: String,
  apellido: String,
  email: String,
  numero: { type: Number, required: true },
  genero: String,
  contraseña: String,
  fecha: { type: Date, default: Date.now },
}));


//ruta de validacion
app.post("/auth", async (req, res) => {
  const { email, contraseña} = req.body;
  
  try{
    const usuario = await Usuarios.findOne({ email});
    if ( !usuario) return res.status(400).json({ error: "usuario incorrecto"});

    const validPassword = await bcrypt.compare(contraseña, usuario.contraseña);
    if (!validPassword) return res.status(400).json({ error: "contraseña incorrecta"});

    const token = jwt.sign({ id: usuario._id}, jwtSecret, { expiresIn: "1h"});
    res.json({ token });
} catch (error) {
  res.status(500).json({ error: "no moleste hombre"});
}
});
// esto madre es para verificar el token
function verificarToken(req, res, next) {
  const token = req.headers["authorization"];
  if (!token) return res.status(403).json({ error: "Token perdido mejor vivo del arte "});

  try{
    const decoded = jwt.verify(token, jwtSecret);
    req.userId = decoded.id;
    next();
  } catch (error) {
    return res.status(401).json({ error: "token inservible parce"});
  }
}
// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://192.168.0.19:${PORT}`);

}); 