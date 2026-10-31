// src/App.js
import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import LoginPage from './components/auth/LoginPage';
import RegisterUserPage from './components/auth/RegisterUserPage';
import DashboardPage from './components/dashboard/DashboardPage';
import InmateListPage from './components/inmates/InmateListPage';
import InmateCapturePage from './components/inmates/InmateCapturePage';
import CentroPenalList from './components/centros/CentroPenalList';
// Importa los demás listados...
import Layout from './components/common/Layout';
import PrivateRoute from './components/routes/PrivateRoute';
import PabellonList from './components/pabellones/PabellonList';
import CeldaList from './components/celdas/CeldaList';
import DefensorList from './components/defensores/DefensorList';
import TrasladoList from './components/traslados/TrasladoList';


function App() {
    return (
        <Routes>
            <Route path="/login" element={<LoginPage />} />
            <Route path="/" element={<Navigate to="/dashboard" />} />
            <Route path="/dashboard" element={<PrivateRoute><Layout /></PrivateRoute>}>
                <Route index element={<DashboardPage />} />
            </Route>
            <Route path="/inmates" element={<PrivateRoute><Layout /></PrivateRoute>}>
                <Route index element={<InmateListPage />} />
            </Route>
            <Route path="/inmate-capture" element={<PrivateRoute><Layout /></PrivateRoute>}>
                <Route index element={<InmateCapturePage />} />
            </Route>
            <Route path="/register-user" element={<PrivateRoute><Layout /></PrivateRoute>}>
                <Route index element={<RegisterUserPage />} />
            </Route>
            <Route path="/centros" element={<PrivateRoute><Layout /></PrivateRoute>}>
                <Route index element={<CentroPenalList />} />
            </Route>
            {/* Agrega rutas para pabellones, celdas, defensores, causas, redenciones, boletas, personal, turnos */}

            <Route path="/pabellones" element={<PrivateRoute><Layout /></PrivateRoute>}>
            <Route index element={<PabellonList />} />
             </Route>
             <Route path="/celdas" element={<PrivateRoute><Layout /></PrivateRoute>}>
             <Route index element={<CeldaList />} />
            </Route>
            <Route path="/defensores" element={<PrivateRoute><Layout /></PrivateRoute>}>
            <Route index element={<DefensorList />} />
            // Dentro de las rutas:
            <Route path="/traslados" element={<PrivateRoute><Layout /></PrivateRoute>}>
                <Route index element={<TrasladoList />} />
            </Route>


        </Route>
        </Routes>
    );
}

export default App;
