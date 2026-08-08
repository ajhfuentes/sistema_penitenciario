// src/services/reclusoService.js
import api from './api';

export const reclusoService = {
    async getAll() {
        const response = await api.get('/reclusos');
        return response.data;
    },
    async getById(id) {
        const response = await api.get(`/reclusos/${id}`);
        return response.data;
    },
    async getByCedula(cedula) {
        const response = await api.get(`/reclusos/cedula/${cedula}`);
        return response.data;
    },
    async getEstadisticas() {
        const response = await api.get('/reclusos/estadisticas');
        return response.data;
    },
    async create(data) {
        const response = await api.post('/reclusos', data);
        return response.data;
    },
    async update(id, data) {
        const response = await api.put(`/reclusos/${id}`, data);
        return response.data;
    },
    async delete(id) {
        const response = await api.delete(`/reclusos/${id}`);
        return response.data;
    },
    async assignCausa(reclusoId, causaId) {
        const response = await api.post(`/reclusos/${reclusoId}/causas`, { causa_id: causaId });
        return response.data;
    },
    async removeCausa(reclusoId, causaId) {
        const response = await api.delete(`/reclusos/${reclusoId}/causas/${causaId}`);
        return response.data;
    },
    async assignDefensor(reclusoId, defensorId) {
        const response = await api.post(`/reclusos/${reclusoId}/defensores`, { defensor_id: defensorId });
        return response.data;
    },
    async removeDefensor(reclusoId, defensorId) {
        const response = await api.delete(`/reclusos/${reclusoId}/defensores/${defensorId}`);
        return response.data;
    }
};
