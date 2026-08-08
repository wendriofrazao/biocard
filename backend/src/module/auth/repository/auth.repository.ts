import { prisma } from "../../../core/data/ConnectionDB.js";
import type { User} from "@prisma/client";
import type { CreateUserDTO } from "../dtos/CreateUserDTO.js";

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

    async createUser(data: CreateUserDTO): Promise<User> {
        try {
            return await prisma.user.create({ data });

        } catch (error) {
            throw new Error(`Error ao criar usuário (repositório): ${error}`);
        }
    }
}