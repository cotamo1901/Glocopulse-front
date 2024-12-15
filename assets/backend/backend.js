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

// Ruta para registrar datos
app.post("/backend", async (req, res) => {
  console.log("Datos recibidos", req.body);
  const { nombre, apellido, email, numero, genero, contraseña} = req.body; 
  if (!nombre || !apellido || !email || !numero || !genero || !contraseña ) {
    return res.status(400).json({ mensaje: "rellena todos los campos"});
  }
  try {
    const UsuariosExistente = await Usuarios.findOne({email});
    if (UsuariosExistente) {
      return res.status(400).json({ mensaje: "el usuario ya existe"});
    }
    const hashedPassword = await bcrypt.hash(contraseña, 10);
    const nuevoUsuarios = new Usuarios({
      nombre, 
      apellido,
      email,
      numero,
      genero,
      contraseña: hashedPassword,
    });

    await nuevoUsuarios.save();
    res.status(201).json({ mensaje: "se ha completado su registro", data: nuevoUsuarios});
     } catch (error) {
      console.error("Usuario Existente", error);
      res.status(500).json({ mensaje: "error al registrar", error});
      } 
       }); 


// esto madre es para verificar el token

// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://192.168.0.19:${PORT}`);

}); 