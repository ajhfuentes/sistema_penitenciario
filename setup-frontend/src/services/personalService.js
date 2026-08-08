// src/services/personalService.js
import api from './api';

export const personalService = {
    async getAll() {
        const response = await api.get('/personal');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/personal/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/personal', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/personal/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/personal/${id}`);
        return response.data;
    }
};
