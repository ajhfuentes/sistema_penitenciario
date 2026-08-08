// src/services/causaPenalService.js
import api from './api';

export const causaPenalService = {
    async getAll() {
        const response = await api.get('/causas-penales');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/causas-penales/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/causas-penales', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/causas-penales/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/causas-penales/${id}`);
        return response.data;
    }
};
