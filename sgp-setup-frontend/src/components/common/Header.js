import React from 'react';
import { useAuth } from '../../context/AuthContext';
import './Header.css';

const Header = () => {
  const { user } = useAuth();

  return (
    <header className="app-header">
      <div className="header-left">
        <span>SISTEMA INTEGRAL PENITENCIARIO</span>
      </div>
      <div className="header-right">
        <span>Bienvenido, {user?.name || 'Usuario'}</span>
        <span className="role-badge">{user?.role || 'Sin rol'}</span>
      </div>
    </header>
  );
};

export default Header;