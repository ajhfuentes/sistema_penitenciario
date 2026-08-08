// src/services/redencionService.js
import api from './api';

export const redencionService = {
    async getAll() {
        const response = await api.get('/redenciones');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/redenciones/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/redenciones', data);
        return response.data;
    },
    async avalar(id) {
        const response = await api.post(`/redenciones/${id}/avalar`);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/redenciones/${id}`);
        return response.data;
    }
};
