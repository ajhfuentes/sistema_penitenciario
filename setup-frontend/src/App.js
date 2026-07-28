import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import LoginPage from './components/auth/LoginPage';
import RegisterUserPage from './components/auth/RegisterUserPage';
import DashboardPage from './components/dashboard/DashboardPage';
import InmateListPage from './components/inmates/InmateListPage';
import InmateCapturePage from './components/inmates/InmateCapturePage';
import Layout from './components/common/Layout';
import PrivateRoute from './components/routes/PrivateRoute';

function App() {
  return (
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/" element={<Navigate to="/dashboard" />} />
      <Route path="/dashboard" element={
        <PrivateRoute>
          <Layout />
        </PrivateRoute>
      }>
        <Route index element={<DashboardPage />} />
      </Route>
      <Route path="/register-user" element={
        <PrivateRoute>
          <Layout />
        </PrivateRoute>
      }>
        <Route index element={<RegisterUserPage />} />
      </Route>
      <Route path="/inmates" element={
        <PrivateRoute>
          <Layout />
        </PrivateRoute>
      }>
        <Route index element={<InmateListPage />} />
      </Route>
      <Route path="/inmate-capture" element={
        <PrivateRoute>
          <Layout />
        </PrivateRoute>
      }>
        <Route index element={<InmateCapturePage />} />
      </Route>
    </Routes>
  );
}

export default App;