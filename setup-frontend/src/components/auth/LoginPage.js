import React, { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faFingerprint, faEye, faUser, faLock, faShieldAlt } from '@fortawesome/free-solid-svg-icons';
import './LoginPage.css';

const LoginPage = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [biometricType, setBiometricType] = useState(null);
    const { login, loading } = useAuth();
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        const result = await login(email, password);
        if (result.success) {
            navigate('/dashboard');
        } else {
            setError(result.error || 'Credenciales incorrectas');
        }
    };

     const handleBiometric = (type) => {
        setBiometricType(type);
        // Simular autenticación biométrica (usa las mismas credenciales para prueba)
        setTimeout(() => {
            login('admin@sgp.com', 'admin123')
                .then(res => {
                    if (res.success) navigate('/dashboard');
                    else setError('Fallo en autenticación biométrica');
                    setBiometricType(null);
                });
        }, 2000);
    };

    return (
        <div className="login-container">
            <div className="login-card">
                <div className="login-header">
                    <h1>
                    <FontAwesomeIcon icon={faShieldAlt} /> Sistema de Gestion Penitenciaria
                    </h1>
                     <p>Secure Access Portal</p>
                </div>

                <form onSubmit={handleSubmit}>
                   <div className="form-group">
                      <label>Email</label>
                      <div className="input-icon">
                            <FontAwesomeIcon icon={faUser} />
                            <input
                            type="email"
                            placeholder="Email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            placeholder="tucorreo@sgp.com"                            
                            required
                            />
                        </div>
                    </div>

                    <div className="form-group">
                        <label>Contraseña</label>
                        <div className="input-icon">
                            <FontAwesomeIcon icon={faLock} />
                            <input
                            type="password"
                            placeholder="Contraseña"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            placeholder="••••••••"
                            required
                             />
                        </div>
                   </div>
                    {error && <div className="error">{error}</div>}
                        <button type="submit" className="btn btn-primary full-width" disabled={loading}>
                        {loading ? 'Autenticando...' : 'ACCEDER AL SISTEMA'}
                        </button>
                
                    <div className="login-links">
                        <a href="#">Olvidé mi contraseña</a>
                        <a href="#">Problemas de acceso? Contacte a Soporte</a>
                    </div>
                </form>

                    <div className="biometric-section">
                        <p>MULTIMODAL BIOMETRIC AUTHENTICATION <small>(Secondary, Optional Access)</small></p>
                        <div className="biometric-buttons">
                            <button
                                className="btn btn-outline biometric-btn"
                                onClick={() => handleBiometric('fingerprint')}
                                disabled={biometricType !== null}
                            >
                                <FontAwesomeIcon icon={faFingerprint} /> FINGERPRINT
                            </button>
                            <button
                                className="btn btn-outline biometric-btn"
                                onClick={() => handleBiometric('iris')}
                                disabled={biometricType !== null}
                            >
                                <FontAwesomeIcon icon={faEye} /> IRIS
                            </button>
                        </div>
                        {biometricType && (
                            <div className="biometric-status">
                                {biometricType === 'fingerprint' ? 'Place finger on reader...' : 'Align eye with camera...'}
                            </div>
                        )}
                    </div>

                    <div className="system-status">
                        <div className="status-item">
                            <span className="status-indicator green"></span> System Status: Green/Online
                        </div>
                        <div className="status-item">
                            <span className="status-indicator"></span> Date / Time: {new Date().toLocaleString()}
                        </div>
                        <div className="status-item notice">
                            ⚠ Important Notice: System Maintenance at 02:00 tomorrow.
                        </div>
                    </div>

            </div>
        </div>
    );
};

export default LoginPage;
