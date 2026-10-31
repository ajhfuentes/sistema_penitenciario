// src/services/exportService.js
import api from './api';

export const exportService = {
    descargarExpediente: async (reclusoId) => {
        try {
            const response = await api.get(`/export/expediente/${reclusoId}`, {
                responseType: 'blob', // Muy importante para archivos binarios
            });
            
            // Crear un enlace temporal para descargar
            const url = window.URL.createObjectURL(new Blob([response.data]));
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', `expediente_${reclusoId}.pdf`);
            document.body.appendChild(link);
            link.click();
            link.remove();
            window.URL.revokeObjectURL(url);
        } catch (error) {
            console.error('Error al descargar el PDF:', error);
            alert('Error al generar el PDF');
        }
    },

    descargarCausa: async (causaId) => {
        try {
            const response = await api.get(`/export/causa/${causaId}`, {
                responseType: 'blob',
            });
            
            const url = window.URL.createObjectURL(new Blob([response.data]));
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', `causa_${causaId}.pdf`);
            document.body.appendChild(link);
            link.click();
            link.remove();
            window.URL.revokeObjectURL(url);
        } catch (error) {
            console.error('Error al descargar la causa:', error);
        }
    },

    descargarBoletaXml: async (boletaId) => {
        try {
            const response = await api.get(`/export/boleta/${boletaId}/xml`, {
                responseType: 'blob',
            });
            
            const url = window.URL.createObjectURL(new Blob([response.data]));
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', `boleta_${boletaId}.xml`);
            document.body.appendChild(link);
            link.click();
            link.remove();
            window.URL.revokeObjectURL(url);
        } catch (error) {
            console.error('Error al descargar la boleta:', error);
        }
    }
};
