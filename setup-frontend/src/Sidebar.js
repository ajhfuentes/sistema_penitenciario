// src/components/common/Sidebar.js
import React from 'react';
import { NavLink } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { 
    faHome, 
    faUsers, 
    faUserPlus, 
    faUserCog, 
    faSignOutAlt, 
    faShieldAlt,
    faExchangeAlt,
    faBuilding,
    faDoorOpen,
    faUserShield,
    faGavel,
    faFileAlt
} from '@fortawesome/free-solid-svg-icons';
import { useAuth } from '../../context/AuthContext';
import './Sidebar.css';

const Sidebar = () => {
    const { logout } = useAuth();

    return (
        <div className="sidebar">
            <div className="sidebar-brand">
                <FontAwesomeIcon icon={faShieldAlt} /> SGP
            </div>
            
            <nav className="sidebar-nav">
                <NavLink to="/dashboard" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faHome} /> Dashboard
                </NavLink>
                
                <NavLink to="/inmates" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faUsers} /> Reclusos
                </NavLink>
                
                <NavLink to="/inmate-capture" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faUserPlus} /> Capturar Recluso
                </NavLink>

                <NavLink to="/traslados" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faExchangeAlt} /> Traslados
                </NavLink>

                <NavLink to="/pabellones" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faBuilding} /> Pabellones
                </NavLink>

                <NavLink to="/celdas" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faDoorOpen} /> Celdas
                </NavLink>

                <NavLink to="/defensores" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faUserShield} /> Defensores
                </NavLink>

                {/* Si tienes componentes para Causas y Redenciones, puedes descomentar estos */}
                {/* 
                <NavLink to="/causas" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faGavel} /> Causas Penales
                </NavLink>
                <NavLink to="/redenciones" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faFileAlt} /> Redenciones
                </NavLink> 
                */}

                <NavLink to="/register-user" className={({ isActive }) => isActive ? 'active' : ''}>
                    <FontAwesomeIcon icon={faUserCog} /> Registrar Usuario
                </NavLink>
            </nav>

            <div className="sidebar-footer">
                <button onClick={logout} className="btn btn-danger">
                    <FontAwesomeIcon icon={faSignOutAlt} /> Cerrar Sesión
                </button>
            </div>
        </div>
    );
};

export default Sidebar;
