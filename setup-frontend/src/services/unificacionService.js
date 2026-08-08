// src/services/unificacionService.js
import api from './api';

export const unificacionService = {
    async create(data) {
        const response = await api.post('/unificaciones', data);
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/unificaciones/${id}`);
        return response.data;
    }
};
