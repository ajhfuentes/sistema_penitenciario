import api from './api';

export const trasladoService = {
    getAll: async () => {
        const response = await api.get('/traslados');
        return response.data;
    },
    create: async (data) => {
        const response = await api.post('/traslados', data);
        return response.data;
    },
    aprobar: async (id, data) => {
        const response = await api.post(`/traslados/${id}/aprobar`, data);
        return response.data;
    },
    rechazar: async (id, data) => {
        const response = await api.post(`/traslados/${id}/rechazar`, data);
        return response.data;
    }
};
