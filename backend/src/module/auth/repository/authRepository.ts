import { prisma } from "../../../core/data/ConnectionDB.js";
import type { User, Prisma } from "@prisma/client";

export class AuthRepository {

    async getUserById(userId: string): Promise<User | null> {
        try {
            const userById = await prisma.user.findUnique({ where: { id: userId } });
            return userById;
        } catch (error) {
            throw new Error(`Error ao buscar usuário por id (repositório): ${error}`);
        }
    }

    async getByEmail(email: string): Promise<User | null> {
        try {
            const userByEmail = await prisma.user.findUnique({ where: { email: email } });
            return userByEmail;
        } catch (error) {
            throw new Error(`Error ao buscar usuário por email (repositório): ${error}`);
        }
    }

    async createUser(data: Prisma.UserCreateInput) {
        try {
            const userCreate = await prisma.user.create({ data });
            return userCreate;
        } catch (error) {
            throw new Error(`Error ao criar usuário (repositório): ${error}`);
        }
    }
}