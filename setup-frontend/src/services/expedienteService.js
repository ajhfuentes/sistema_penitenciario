// src/services/expedienteService.js
import api from './api';

export const expedienteService = {
    async getByRecluso(reclusoId) {
        const response = await api.get(`/expedientes/recluso/${reclusoId}`);
        return response.data;
    },
    async cerrar(expedienteId) {
        const response = await api.post(`/expedientes/${expedienteId}/cerrar`);
        return response.data;
    },
    async getCausas(expedienteId) {
        const response = await api.get(`/expedientes/${expedienteId}/causas`);
        return response.data;
    }
};
