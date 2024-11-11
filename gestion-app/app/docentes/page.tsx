"use client";

import { useState, useEffect } from 'react';

interface Docente {
  teacher_id?: number; 
  first_name: string;
  last_name: string;
  email: string;
  phone_number?: string;
  max_credits: number;
  rut_login?: string;
  password?: string;
  contract?: string;
  status?: boolean | null;
}

export default function Docentes() {
  const [docentes, setDocentes] = useState<Docente[]>([]);
  const [selectedDocente, setSelectedDocente] = useState<Docente | null>(null);
  const [newDocente, setNewDocente] = useState<Docente>({
    first_name: '',
    last_name: '',
    email: '',
    phone_number: '',
    max_credits: 0,
    rut_login: '',
    password: '',
    contract: '',
    status: true,
  });
  const [searchTerm, setSearchTerm] = useState<string>('');
  const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
  const [isInfoModalOpen, setIsInfoModalOpen] = useState<boolean>(false);
  const [isEditing, setIsEditing] = useState<boolean>(false);

  useEffect(() => {
    async function fetchDocentes() {
      const res = await fetch('/api/docentes');
      const data = await res.json();
      setDocentes(data);
    }
    fetchDocentes();
  }, []);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;
    setNewDocente((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value,
    }));
  };

  const isRutValid = (rut: string) => {
    const rutRegex = /^[0-9]{8}-[0-9kK]{1}$/;
    return rutRegex.test(rut);
  };

  const isFormValid = () => {
    return newDocente.first_name.trim() !== '' &&
           newDocente.last_name.trim() !== '' &&
           newDocente.email.trim() !== '' &&
           newDocente.max_credits > 0 &&
           newDocente.phone_number?.trim() !== '' &&
           isRutValid(newDocente.rut_login || '') &&
           newDocente.password?.trim() !== '' &&
           newDocente.contract?.trim() !== '';
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (isFormValid()) {
      const url = isEditing ? `/api/docentes?id=${newDocente.teacher_id}` : '/api/docentes';
      const method = isEditing ? 'PUT' : 'POST';
  
      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(newDocente),
      });
  
      const result = await response.json();
      if (response.ok) {
        if (isEditing) {
          setDocentes((prev) =>
            prev.map((docente) => (docente.teacher_id === result.teacher_id ? result : docente))
          );
          alert('Docente actualizado exitosamente');
        } else {
          setDocentes((prev) => [...prev, result]);
          alert('Docente agregado exitosamente');
        }
        setIsModalOpen(false);
        setIsEditing(false);
        setNewDocente({
          first_name: '',
          last_name: '',
          email: '',
          phone_number: '',
          max_credits: 0,
          rut_login: '',
          password: '',
          contract: '',
          status: true,
        });
      } else {
        alert(result.error || 'Error al guardar el docente');
      }
    } else {
      alert("Por favor, completa todos los campos obligatorios sin espacios en blanco y asegúrate de que el RUT tenga el formato correcto (8 dígitos, guión y un dígito o 'k').");
    }
  };

  const handleAgregarDocente = () => {
    setIsModalOpen(true);
    setIsEditing(false);
  };

  const handleModalClose = () => {
    setIsModalOpen(false);
    setNewDocente({
      first_name: '',
      last_name: '',
      email: '',
      phone_number: '',
      max_credits: 0,
      rut_login: '',
      password: '',
      contract: '',
      status: true,
    });
    setIsEditing(false);
  };

  const handleVerInfo = (docente: Docente) => {
    setSelectedDocente(docente);
    setIsInfoModalOpen(true);
  };

  const handleInfoModalClose = () => {
    setIsInfoModalOpen(false);
    setSelectedDocente(null);
  };

  const handleEditDocente = (docente: Docente) => {
    setNewDocente(docente);
    setIsEditing(true);
    setIsModalOpen(true);
    setIsInfoModalOpen(false);
  };

  const handleDeleteDocente = async (id: number) => {
    const confirmDelete = window.confirm('¿Estás seguro de que deseas eliminar este docente?');
    if (confirmDelete) {
      try {
        const response = await fetch(`/api/docentes?id=${id}`, {
          method: 'DELETE',
        });

        if (response.ok) {
          setDocentes((prevDocentes) => prevDocentes.filter(docente => docente.teacher_id !== id));
          setIsInfoModalOpen(false);
          alert('Docente eliminado exitosamente');
        } else {
          alert('Error al eliminar el docente');
        }
      } catch (error) {
        console.error('Error al eliminar el docente:', error);
        alert('Error al eliminar el docente');
      }
    }
  };

  const filteredDocentes = docentes.filter((docente) =>
    `${docente.first_name} ${docente.last_name}`.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="layout docentes-page">
      <style>{`
        .layout {
          font-family: Arial, sans-serif;
          margin: 20px;
        }
        .add-docente-btn {
          background-color: #4CAF50;
          color: white;
          border: none;
          padding: 10px 20px;
          cursor: pointer;
          border-radius: 5px;
          margin-bottom: 20px;
        }
        .search-bar {
          margin-bottom: 20px;
        }
        .search-bar input {
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 5px;
          width: 300px;
        }
        .docentes-container {
          display: flex;
          justify-content: space-between;
        }
        .docentes-column {
          width: 48%;
          border: 1px solid #ccc;
          border-radius: 5px;
          padding: 10px;
          background-color: #f9f9f9;
        }
        .docentes-list {
          list-style-type: none;
          padding: 0;
        }
        .docente-item {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 8px 0;
          border-bottom: 1px solid #ccc;
        }
        .docente-item:last-child {
          border-bottom: none;
        }
        .docente-info {
          font-weight: bold;
        }
        .modal-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background-color: rgba(0, 0, 0, 0.7);
          display: flex;
          justify-content: center;
          align-items: center;
        }
        .modal {
          background-color: white;
          padding: 20px;
          border-radius: 8px;
          width: 400px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .modal h2 {
          margin: 0 0 15px;
        }
        .modal input, .modal button {
          width: 100%;
          padding: 10px;
          margin: 5px 0;
          border: 1px solid #ccc;
          border-radius: 5px;
        }
        .modal button {
          background-color: #4CAF50;
          color: white;
          border: none;
          cursor: pointer;
        }
        .modal button:hover {
          background-color: #45a049;
        }
        .delete-btn {
          background-color: #ff0000 !important;
        }
        .delete-btn:hover {
          background-color: #cc0000 !important;
        }
      `}</style>

      <button className="add-docente-btn" onClick={handleAgregarDocente}>Agregar Docente</button>

      <div className="search-bar">
        <input
          type="text"
          placeholder="Buscar docente por nombre"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </div>

      <div className="docentes-container">
        <div className="docentes-column">
          <h2>Docentes Activos</h2>
          <ul className="docentes-list">
            {filteredDocentes
              .filter((docente) => docente.status === true)
              .map((docente) => (
                <li key={docente.teacher_id} className="docente-item">
                  {docente.first_name} {docente.last_name}
                  <button onClick={() => handleVerInfo(docente)}>Ver Información</button>
                </li>
              ))}
          </ul>
        </div>

        <div className="docentes-column">
          <h2>Docentes Inactivos</h2>
          <ul className="docentes-list">
            {filteredDocentes
              .filter((docente) => docente.status === false)
              .map((docente) => (
                <li key={docente.teacher_id} className="docente-item">
                  {docente.first_name} {docente.last_name}
                  <button onClick={() => handleVerInfo(docente)}>Ver Información</button>
                </li>
              ))}
          </ul>
        </div>
      </div>

      {isModalOpen && (
        <div className="modal-overlay">
          <div className="modal">
            <h2>{isEditing ? 'Editar Docente' : 'Agregar Docente'}</h2>
            <form onSubmit={handleSubmit}>
              <input
                type="text"
                name="first_name"
                placeholder="Nombre"
                value={newDocente.first_name}
                onChange={handleInputChange}
                required
              />
              <input
                type="text"
                name="last_name"
                placeholder="Apellido"
                value={newDocente.last_name}
                onChange={handleInputChange}
                required
              />
              <input
                type="email"
                name="email"
                placeholder="Email"
                value={newDocente.email}
                onChange={handleInputChange}
                required
              />
              <input
                type="text"
                name="phone_number"
                placeholder="Teléfono"
                value={newDocente.phone_number}
                onChange={handleInputChange}
                required
              />
              <input
                type="number"
                name="max_credits"
                placeholder="Créditos Máximos"
                value={newDocente.max_credits}
                onChange={handleInputChange}
                required
              />
              <input
                type="text"
                name="rut_login"
                placeholder="RUT (formato: 12345678-9)"
                value={newDocente.rut_login}
                onChange={handleInputChange}
                required
              />
              <input
                type="password"
                name="password"
                placeholder="Contraseña"
                value={newDocente.password}
                onChange={handleInputChange}
                required
              />
              <input
                type="text"
                name="contract"
                placeholder="Contrato"
                value={newDocente.contract}
                onChange={handleInputChange}
                required
              />
              <label>
                Estado:
                <input
                  type="checkbox"
                  name="status"
                  checked={newDocente.status || false}
                  onChange={handleInputChange}
                />
              </label>
              <button type="submit">{isEditing ? 'Guardar Cambios' : 'Agregar'}</button>
              <button type="button" onClick={handleModalClose}>Cancelar</button>
            </form>
          </div>
        </div>
      )}

      {isInfoModalOpen && selectedDocente && (
        <div className="modal-overlay">
          <div className="modal">
            <h2>Información del Docente</h2>
            <p><strong>Nombre:</strong> {selectedDocente.first_name} {selectedDocente.last_name}</p>
            <p><strong>Email:</strong> {selectedDocente.email}</p>
            <p><strong>Teléfono:</strong> {selectedDocente.phone_number}</p>
            <p><strong>Créditos Máximos:</strong> {selectedDocente.max_credits}</p>
            <p><strong>RUT:</strong> {selectedDocente.rut_login}</p>
            <p><strong>Contrato:</strong> {selectedDocente.contract}</p>
            <p><strong>Estado:</strong> {selectedDocente.status ? 'Activo' : 'Inactivo'}</p>
            <button onClick={() => handleEditDocente(selectedDocente)}>Modificar</button>
            <button className="delete-btn" onClick={() => handleDeleteDocente(selectedDocente.teacher_id!)}>Eliminar</button>
            <button onClick={handleInfoModalClose}>Cerrar</button>
          </div>
        </div>
      )}
    </div>
  );
}