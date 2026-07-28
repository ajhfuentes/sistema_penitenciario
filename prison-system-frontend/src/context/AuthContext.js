import React, { createContext, useState, useContext } from 'react';
import { mockUsers } from '../services/mockData';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);

  const login = (username, password) => {
    setLoading(true);
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const found = mockUsers.find(u => u.username === username && u.password === password);
        if (found) {
          setUser(found);
          resolve(found);
        } else {
          reject(new Error('Credenciales incorrectas'));
        }
        setLoading(false);
      }, 500);
    });
  };

  const logout = () => {
    setUser(null);
  };

  const hasRole = (role) => {
    return user && user.role === role;
  };

  const hasPermission = (module, action) => {
    if (!user) return false;
    // Simulamos permisos según rol
    if (user.role === 'Administrador') return true;
    if (user.role === 'Oficial de Campo') {
      if (module === 'Módulo de Criminales' && (action === 'visualización' || action === 'edición')) return true;
      if (module === 'Historiales' && action === 'visualización') return true;
    }
    if (user.role === 'Analista de Inteligencia') {
      if (module === 'Módulo de Criminales' && (action === 'visualización' || action === 'creación')) return true;
      if (module === 'Reportes' && action === 'visualización') return true;
    }
    return false;
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, loading, hasRole, hasPermission }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);