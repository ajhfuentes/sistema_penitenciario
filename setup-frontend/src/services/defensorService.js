// src/services/defensorService.js
import api from './api';

export const defensorService = {
    async getAll() {
        const response = await api.get('/defensores');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/defensores/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/defensores', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/defensores/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/defensores/${id}`);
        return response.data;
    }
};
