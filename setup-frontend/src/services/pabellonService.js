// src/services/pabellonService.js
import api from './api';

export const pabellonService = {
    async getAll() {
        const response = await api.get('/pabellones');
        return response.data;
    },
    async getByCentro(centroId) {
        const response = await api.get(`/pabellones?centro_penal_id=${centroId}`);
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/pabellones/${id}`);
        return response.data;
    },
    async create(data) {
        const response = await api.post('/pabellones', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/pabellones/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/pabellones/${id}`);
        return response.data;
    }
};
