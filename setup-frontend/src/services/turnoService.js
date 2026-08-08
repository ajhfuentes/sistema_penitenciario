// src/services/turnoService.js
import api from './api';

export const turnoService = {
    async getAll() {
        const response = await api.get('/turnos');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/turnos/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/turnos', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/turnos/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/turnos/${id}`);
        return response.data;
    }
};
