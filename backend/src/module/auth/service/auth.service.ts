import { AuthRepository } from "../repository/auth.repository.js";

export class AuthService {

    async loginService() {
        try {

        } catch (error) {
            throw new Error(`Erro ao entrar (service): ${error}`);
        }
    }

    async logupService() {
        try {

        } catch (error) {
            throw new Error(`Erro ao se registrar (service): ${error}`);
        }
    }

    async profileService() {
        try {

        } catch (error) {
            throw new Error(`Erro ao entrar no perfil (service): ${error}`);
        }
    }

}