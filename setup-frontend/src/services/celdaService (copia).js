// src/services/celdaService.js
import api from './api';

export const celdaService = {
    async getAll() {
        const response = await api.get('/celdas');
        return response.data;
    },
    async getByPabellon(pabellonId) {
        const response = await api.get(`/celdas?pabellon_id=${pabellonId}`);
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/celdas/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/celdas', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/celdas/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/celdas/${id}`);
        return response.data;
    }
};
