// src/services/boletaService.js
import api from './api';

export const boletaService = {
    async getAll() {
        const response = await api.get('/boletas');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/boletas/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/boletas', data);
        return response.data;
    },
    async desactivar(id) {
        const response = await api.post(`/boletas/${id}/desactivar`);
        return response.data;
    }
};
