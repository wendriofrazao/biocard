import jwt from "jsonwebtoken";
import type { UserRole } from "@prisma/client";

interface JwtPayload {
    id: string;
    email: string;
    role: UserRole;
}

export class JwtService {
    private readonly secret: string;

    constructor() {
        const secret = process.env.JWT_SECRET;
        if (!secret) throw new Error("JWT_SECRET não configurado");
        this.secret = secret;
    }

    generateToken(payload: JwtPayload): string {
        try {
            return jwt.sign(payload, this.secret, { expiresIn: "1d" });
        } catch (error) {
            throw new Error(`Erro ao criar token (service): ${error}`);
        }
    }

    verifyToken(token: string): JwtPayload {
        try {
            const decoded = jwt.verify( token, this.secret );
            if (typeof decoded === "string") throw new Error("Payload do token inválido");
            return decoded as JwtPayload;
        } catch (error) {
            throw new Error(`Erro ao verificar token (service): ${error}`);
        }
    }

}