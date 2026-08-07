import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import dotenv from 'dotenv';

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });

export const prisma = new PrismaClient({
    log: [
        "query",
        "error",
        "warn"
    ],
    adapter: adapter
});


export async function connectDatabase() {
    try {
        await prisma.$connect();
        console.log("Prisma conectado ao PostgreSQL");
    } catch (error) {
        console.error("Erro ao conectar Prisma:", error);
        process.exit(1);
    }
}