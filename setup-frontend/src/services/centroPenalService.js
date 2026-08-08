// src/services/centroPenalService.js
import api from './api';

export const centroPenalService = {
    async getAll() {
        const response = await api.get('/centros-penales');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/centros-penales/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/centros-penales', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/centros-penales/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/centros-penales/${id}`);
        return response.data;
    }
};
