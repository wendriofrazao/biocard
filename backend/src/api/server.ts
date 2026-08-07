import express from "express";
import { router } from "./routes.js";
import { connectDatabase } from "../core/data/ConnectionDB.js";
import dotenv from 'dotenv';
import cors from 'cors';

dotenv.config();

// conexão com o postgres
connectDatabase();

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(cors({
    origin: ""
}));

app.use(router);

app.listen(process.env.PORT, () => {
    console.log(`Servidor iniciado com sucesso! -> http://localhost:${process.env.PORT}`);
});