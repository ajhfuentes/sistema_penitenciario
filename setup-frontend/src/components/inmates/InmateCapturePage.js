// src/components/inmates/InmateCapturePage.js
import React, { useState, useEffect } from 'react';
import { reclusoService } from '../../services/reclusoService';
import { centroPenalService } from '../../services/centroPenalService';
import { pabellonService } from '../../services/pabellonService';
import { celdaService } from '../../services/celdaService';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { 
    faFingerprint, faEye, faUserPlus, faCheckCircle, 
    faClock, faArrowRight, faArrowLeft, faSave, faTimes,
    faSearch, faSync, faBuilding, faDoorOpen, faUsers
} from '@fortawesome/free-solid-svg-icons';
import './InmateCapturePage.css';

const InmateCapturePage = () => {
    // Estados de formulario
    const [form, setForm] = useState({
        nombres: '',
        apellidos: '',
        cedula_identidad: '',
        fecha_nacimiento: '',
        nacionalidad: 'Venezolana',
        sexo: 'M',
        nivel_riesgo: 'Bajo',
        estado_operativo: 'En Ingreso',
        celda_id: '',
        huella_dactilar: '',
        delito_principal: '',
        historial_delictivo: '',
        afiliacion_pandillas: '',
        comportamiento: '',
    });

    // Estados de UI
    const [currentStep, setCurrentStep] = useState(0);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [success, setSuccess] = useState(false);
    const [biometricScanning, setBiometricScanning] = useState(false);
    const [biometricType, setBiometricType] = useState(null);

    // Datos para selects
    const [centros, setCentros] = useState([]);
    const [pabellones, setPabellones] = useState([]);
    const [celdas, setCeldas] = useState([]);
    const [transferRequests, setTransferRequests] = useState([]);

    // Pasos del flujo
    const steps = [
        'Captura Biométrica',
        'Datos Personales',
        'Evaluación de Riesgo',
        'Asignación de Celda',
        'Revisión Final'
    ];

    // Cargar datos iniciales
    useEffect(() => {
        loadCatalogData();
    }, []);

    const loadCatalogData = async () => {
        try {
            const [centrosData, pabellonesData, celdasData] = await Promise.all([
                centroPenalService.getAll(),
                pabellonService.getAll(),
                celdaService.getAll()
            ]);
            setCentros(centrosData.data || []);
            setPabellones(pabellonesData.data || []);
            setCeldas(celdasData.data || []);
        } catch (err) {
            console.error('Error cargando catálogos:', err);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        
        // Si cambia la celda, actualizar el riesgo sugerido según el pabellón
        if (name === 'celda_id' && value) {
            const celda = celdas.find(c => c.id === parseInt(value));
            if (celda) {
                const pabellon = pabellones.find(p => p.id === celda.pabellon_id);
                if (pabellon) {
                    // Sugerir riesgo compatible
                    const riesgosComunes = {
                        'Alto': 'Alto',
                        'Medio': 'Medio',
                        'Bajo': 'Bajo'
                    };
                    if (riesgosComunes[pabellon.riesgo_permitido]) {
                        setForm(prev => ({
                            ...prev,
                            nivel_riesgo: riesgosComunes[pabellon.riesgo_permitido]
                        }));
                    }
                }
            }
        }
    };

    const handleBiometricScan = (type) => {
        setBiometricType(type);
        setBiometricScanning(true);
        
        // Simular escaneo biométrico
        setTimeout(() => {
            setBiometricScanning(false);
            setBiometricType(null);
            // Avanzar al siguiente paso después de la biometría
            if (currentStep === 0) {
                setCurrentStep(1);
            }
        }, 2000);
    };

    const nextStep = () => {
        if (currentStep < steps.length - 1) {
            setCurrentStep(currentStep + 1);
        }
    };

    const prevStep = () => {
        if (currentStep > 0) {
            setCurrentStep(currentStep - 1);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError(null);
        setLoading(true);

        try {
            const data = {
                nombres: form.nombres,
                apellidos: form.apellidos,
                cedula_identidad: form.cedula_identidad,
                fecha_nacimiento: form.fecha_nacimiento || null,
                sexo: form.sexo,
                nivel_riesgo: form.nivel_riesgo,
                estado_operativo: form.estado_operativo,
                celda_id: form.celda_id ? parseInt(form.celda_id) : null,
                huella_dactilar: form.huella_dactilar || null,
            };

            await reclusoService.create(data);
            setSuccess(true);
            setError(null);
            
            // Limpiar formulario después de 3 segundos
            setTimeout(() => {
                setSuccess(false);
                setForm({
                    nombres: '',
                    apellidos: '',
                    cedula_identidad: '',
                    fecha_nacimiento: '',
                    nacionalidad: 'Venezolana',
                    sexo: 'M',
                    nivel_riesgo: 'Bajo',
                    estado_operativo: 'En Ingreso',
                    celda_id: '',
                    huella_dactilar: '',
                    delito_principal: '',
                    historial_delictivo: '',
                    afiliacion_pandillas: '',
                    comportamiento: '',
                });
                setCurrentStep(0);
            }, 3000);

        } catch (err) {
            setError(err.response?.data?.message || 'Error al registrar el recluso');
        } finally {
            setLoading(false);
        }
    };

    // Obtener nombre de pabellón
    const getPabellonNombre = (celdaId) => {
        const celda = celdas.find(c => c.id === parseInt(celdaId));
        if (!celda) return 'N/A';
        const pabellon = pabellones.find(p => p.id === celda.pabellon_id);
        return pabellon?.nombre || 'N/A';
    };

    const getCeldaCodigo = (celdaId) => {
        const celda = celdas.find(c => c.id === parseInt(celdaId));
        return celda?.codigo || 'N/A';
    };

    return (
        <div className="inmate-capture-container">
            <h2>📸 Captura de Nuevo Recluso</h2>

            {/* Indicador de pasos */}
            <div className="card step-indicator">
                <div className="steps-bar">
                    {steps.map((step, idx) => (
                        <div key={idx} className={`step-item ${idx === currentStep ? 'active' : idx < currentStep ? 'completed' : ''}`}>
                            <div className="step-circle">
                                {idx < currentStep ? <FontAwesomeIcon icon={faCheckCircle} /> : idx + 1}
                            </div>
                            <div className="step-label">{step}</div>
                            {idx < steps.length - 1 && <div className="step-line"></div>}
                        </div>
                    ))}
                </div>
            </div>

            {success && (
                <div className="alert alert-success">
                    <FontAwesomeIcon icon={faCheckCircle} /> ¡Recluso registrado exitosamente!
                </div>
            )}

            {error && (
                <div className="alert alert-danger">
                    <strong>Error:</strong> {error}
                </div>
            )}

            <form onSubmit={handleSubmit}>
                {/* Step 0: Captura Biométrica */}
                {currentStep === 0 && (
                    <div className="card step-content">
                        <div className="card-title">🔐 Captura Biométrica</div>
                        <div className="biometric-container">
                            <div className="biometric-grid">
                                <div className="biometric-card" onClick={() => handleBiometricScan('fingerprint')}>
                                    <div className="biometric-icon">
                                        <FontAwesomeIcon icon={faFingerprint} />
                                    </div>
                                    <h4>Huella Digital</h4>
                                    <p>Registrar huellas dactilares</p>
                                    {biometricScanning && biometricType === 'fingerprint' && (
                                        <div className="scanning-status">
                                            <div className="spinner"></div>
                                            <span>Escaneando...</span>
                                        </div>
                                    )}
                                    <button 
                                        type="button" 
                                        className="btn btn-primary"
                                        disabled={biometricScanning}
                                    >
                                        {biometricScanning && biometricType === 'fingerprint' ? 'Escaneando...' : 'Iniciar Escaneo'}
                                    </button>
                                </div>

                                <div className="biometric-card" onClick={() => handleBiometricScan('iris')}>
                                    <div className="biometric-icon">
                                        <FontAwesomeIcon icon={faEye} />
                                    </div>
                                    <h4>Escaneo de Iris</h4>
                                    <p>Registrar patrón de iris</p>
                                    {biometricScanning && biometricType === 'iris' && (
                                        <div className="scanning-status">
                                            <div className="spinner"></div>
                                            <span>Escaneando...</span>
                                        </div>
                                    )}
                                    <button 
                                        type="button" 
                                        className="btn btn-primary"
                                        disabled={biometricScanning}
                                    >
                                        {biometricScanning && biometricType === 'iris' ? 'Escaneando...' : 'Iniciar Escaneo'}
                                    </button>
                                </div>
                            </div>
                            <div className="biometric-info">
                                <p>💡 La captura biométrica es opcional pero recomendada para la identificación segura.</p>
                            </div>
                        </div>
                    </div>
                )}

                {/* Step 1: Datos Personales */}
                {currentStep === 1 && (
                    <div className="card step-content">
                        <div className="card-title">📝 Datos Personales</div>
                        <div className="form-row">
                            <div className="form-group">
                                <label>Nombres *</label>
                                <input
                                    type="text"
                                    name="nombres"
                                    value={form.nombres}
                                    onChange={handleChange}
                                    placeholder="Nombres completos"
                                    required
                                />
                            </div>
                            <div className="form-group">
                                <label>Apellidos *</label>
                                <input
                                    type="text"
                                    name="apellidos"
                                    value={form.apellidos}
                                    onChange={handleChange}
                                    placeholder="Apellidos completos"
                                    required
                                />
                            </div>
                        </div>

                        <div className="form-row">
                            <div className="form-group">
                                <label>Cédula de Identidad *</label>
                                <input
                                    type="text"
                                    name="cedula_identidad"
                                    value={form.cedula_identidad}
                                    onChange={handleChange}
                                    placeholder="V-12345678"
                                    required
                                />
                            </div>
                            <div className="form-group">
                                <label>Fecha de Nacimiento</label>
                                <input
                                    type="date"
                                    name="fecha_nacimiento"
                                    value={form.fecha_nacimiento}
                                    onChange={handleChange}
                                />
                            </div>
                        </div>

                        <div className="form-row">
                            <div className="form-group">
                                <label>Nacionalidad</label>
                                <input
                                    type="text"
                                    name="nacionalidad"
                                    value={form.nacionalidad}
                                    onChange={handleChange}
                                    placeholder="Nacionalidad"
                                />
                            </div>
                            <div className="form-group">
                                <label>Sexo</label>
                                <select name="sexo" value={form.sexo} onChange={handleChange}>
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                        </div>
                    </div>
                )}

                {/* Step 2: Evaluación de Riesgo */}
                {currentStep === 2 && (
                    <div className="card step-content">
                        <div className="card-title">⚠️ Evaluación de Riesgo</div>
                        
                        <div className="form-group">
                            <label>Delito Principal</label>
                            <input
                                type="text"
                                name="delito_principal"
                                value={form.delito_principal}
                                onChange={handleChange}
                                placeholder="Delito por el que fue imputado"
                            />
                        </div>

                        <div className="form-group">
                            <label>Historial Delictivo</label>
                            <textarea
                                name="historial_delictivo"
                                value={form.historial_delictivo}
                                onChange={handleChange}
                                rows="2"
                                placeholder="Antecedentes penales"
                            />
                        </div>

                        <div className="form-row">
                            <div className="form-group">
                                <label>Afiliación a Pandillas</label>
                                <input
                                    type="text"
                                    name="afiliacion_pandillas"
                                    value={form.afiliacion_pandillas}
                                    onChange={handleChange}
                                    placeholder="Nombre de pandilla (si aplica)"
                                />
                            </div>
                            <div className="form-group">
                                <label>Nivel de Riesgo *</label>
                                <select
                                    name="nivel_riesgo"
                                    value={form.nivel_riesgo}
                                    onChange={handleChange}
                                    required
                                >
                                    <option value="Bajo">Bajo</option>
                                    <option value="Medio">Medio</option>
                                    <option value="Alto">Alto</option>
                                </select>
                            </div>
                        </div>

                        <div className="form-group">
                            <label>Comportamiento en Tránsito</label>
                            <input
                                type="text"
                                name="comportamiento"
                                value={form.comportamiento}
                                onChange={handleChange}
                                placeholder="Observaciones de comportamiento"
                            />
                        </div>

                        <div className="risk-assessment-box">
                            <h4>📊 Evaluación Sugerida</h4>
                            <div className="risk-level">
                                <span>Riesgo Asignado:</span>
                                <span className={`risk-badge ${form.nivel_riesgo.toLowerCase()}`}>
                                    {form.nivel_riesgo}
                                </span>
                            </div>
                            <p className="help-text">El nivel de riesgo debe ser compatible con el pabellón asignado.</p>
                        </div>
                    </div>
                )}

                {/* Step 3: Asignación de Celda */}
                {currentStep === 3 && (
                    <div className="card step-content">
                        <div className="card-title">🏠 Asignación de Celda</div>
                        
                        <div className="form-group">
                            <label>Estado Operativo *</label>
                            <select
                                name="estado_operativo"
                                value={form.estado_operativo}
                                onChange={handleChange}
                                required
                            >
                                <option value="En Ingreso">En Ingreso</option>
                                <option value="Activo">Activo</option>
                                <option value="Traslado">Traslado</option>
                            </select>
                        </div>

                        <div className="form-group">
                            <label>Asignar Celda</label>
                            <select
                                name="celda_id"
                                value={form.celda_id}
                                onChange={handleChange}
                            >
                                <option value="">Sin asignar</option>
                                {celdas.map(c => {
                                    const pabellon = pabellones.find(p => p.id === c.pabellon_id);
                                    return (
                                        <option key={c.id} value={c.id}>
                                            {c.codigo} - {pabellon?.nombre || 'Sin pabellón'} 
                                            (Cap. {c.capacidad_maxima})
                                        </option>
                                    );
                                })}
                            </select>
                        </div>

                        {form.celda_id && (
                            <div className="assignment-preview">
                                <h4>📋 Asignación Seleccionada</h4>
                                <div className="preview-grid">
                                    <div className="preview-item">
                                        <label>Celda:</label>
                                        <span>{getCeldaCodigo(form.celda_id)}</span>
                                    </div>
                                    <div className="preview-item">
                                        <label>Pabellón:</label>
                                        <span>{getPabellonNombre(form.celda_id)}</span>
                                    </div>
                                    <div className="preview-item">
                                        <label>Riesgo Permitido:</label>
                                        <span>
                                            {pabellones.find(p => 
                                                p.id === celdas.find(c => c.id === parseInt(form.celda_id))?.pabellon_id
                                            )?.riesgo_permitido || 'N/A'}
                                        </span>
                                    </div>
                                    <div className="preview-item">
                                        <label>Recluso con Riesgo:</label>
                                        <span className={`risk-badge ${form.nivel_riesgo.toLowerCase()}`}>
                                            {form.nivel_riesgo}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        )}
                    </div>
                )}

                {/* Step 4: Revisión Final */}
                {currentStep === 4 && (
                    <div className="card step-content">
                        <div className="card-title">✅ Revisión Final</div>
                        
                        <div className="review-grid">
                            <div className="review-section">
                                <h4>Datos Personales</h4>
                                <div className="review-item">
                                    <span>Nombre:</span>
                                    <strong>{form.nombres} {form.apellidos}</strong>
                                </div>
                                <div className="review-item">
                                    <span>Cédula:</span>
                                    <strong>{form.cedula_identidad}</strong>
                                </div>
                                <div className="review-item">
                                    <span>Fecha Nacimiento:</span>
                                    <strong>{form.fecha_nacimiento || 'N/A'}</strong>
                                </div>
                                <div className="review-item">
                                    <span>Sexo:</span>
                                    <strong>{form.sexo === 'M' ? 'Masculino' : 'Femenino'}</strong>
                                </div>
                            </div>

                            <div className="review-section">
                                <h4>Evaluación de Riesgo</h4>
                                <div className="review-item">
                                    <span>Nivel de Riesgo:</span>
                                    <span className={`risk-badge ${form.nivel_riesgo.toLowerCase()}`}>
                                        {form.nivel_riesgo}
                                    </span>
                                </div>
                                <div className="review-item">
                                    <span>Delito Principal:</span>
                                    <strong>{form.delito_principal || 'No especificado'}</strong>
                                </div>
                                <div className="review-item">
                                    <span>Historial:</span>
                                    <strong>{form.historial_delictivo || 'Sin antecedentes'}</strong>
                                </div>
                            </div>

                            <div className="review-section">
                                <h4>Asignación</h4>
                                <div className="review-item">
                                    <span>Estado:</span>
                                    <strong>{form.estado_operativo}</strong>
                                </div>
                                <div className="review-item">
                                    <span>Celda:</span>
                                    <strong>{form.celda_id ? getCeldaCodigo(form.celda_id) : 'Sin asignar'}</strong>
                                </div>
                                <div className="review-item">
                                    <span>Pabellón:</span>
                                    <strong>{form.celda_id ? getPabellonNombre(form.celda_id) : 'N/A'}</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                )}

                {/* Navegación */}
                <div className="step-navigation">
                    <button
                        type="button"
                        className="btn btn-secondary"
                        onClick={prevStep}
                        disabled={currentStep === 0}
                    >
                        <FontAwesomeIcon icon={faArrowLeft} /> Anterior
                    </button>
                    
                    {currentStep === steps.length - 1 ? (
                        <button 
                            type="submit" 
                            className="btn btn-success"
                            disabled={loading}
                        >
                            <FontAwesomeIcon icon={faSave} /> 
                            {loading ? 'Registrando...' : 'Registrar Recluso'}
                        </button>
                    ) : (
                        <button
                            type="button"
                            className="btn btn-primary"
                            onClick={nextStep}
                        >
                            Siguiente <FontAwesomeIcon icon={faArrowRight} />
                        </button>
                    )}
                </div>
            </form>
        </div>
    );
};

export default InmateCapturePage;
