import type { UserRole } from "@prisma/client";

export interface CreateUserDTO {
    name: string;
    email: string;
    password: string;
    role: UserRole;
    avatar?: string;
}