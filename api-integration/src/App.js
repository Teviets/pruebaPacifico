import React, { useState, useEffect } from 'react';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogTitle from '@mui/material/DialogTitle';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import TextField from '@mui/material/TextField';
import './App.css'

export default function BasicTable() {
  const [open, setOpen] = useState(false);
  const [users, setUsers] = useState([]);
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    age: '',
    email: '',
    phone: '',
  });

  // Hacer GET a https://dummyjson.com/users cuando el componente se monta
  useEffect(() => {
    fetch('https://dummyjson.com/users')
      .then((res) => res.json())
      .then((data) => setUsers(data.users))
      .catch((error) => console.error('Error al obtener los usuarios:', error));
  }, []);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    // Hacer POST al enviar el formulario
    fetch('https://dummyjson.com/users/add', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        firstName: formData.firstName,
        lastName: formData.lastName,
        age: formData.age,
        email: formData.email,
        phone: formData.phone,
      }),
    })
      .then((res) => res.json())
      .then((newUser) => {
        // Agregar el nuevo usuario al inicio de la lista
        setUsers((prevUsers) => [newUser, ...prevUsers]);
        setOpen(false); // Cerrar el Dialog
      })
      .catch((error) => console.error('Error al agregar el usuario:', error));
  };

  return (
    <div id='app'>
      
      <header id='headerTable'>

        <h1>User Table</h1>

        <div id='containerbtn'>
          <Button id='flotante' variant="contained" color="primary" onClick={handleClickOpen}>
            Agregar Usuario
          </Button>
        </div>

      </header>

      <Dialog open={open} onClose={handleClose} aria-labelledby="form-dialog-title">
        <DialogTitle id="form-dialog-title">Agregar Nuevo Usuario</DialogTitle>
        <DialogContent>
          <form onSubmit={handleSubmit}>
            <TextField
              margin="dense"
              label="Nombre"
              name="firstName"
              fullWidth
              value={formData.firstName}
              onChange={handleChange}
            />
            <TextField
              margin="dense"
              label="Apellido"
              name="lastName"
              fullWidth
              value={formData.lastName}
              onChange={handleChange}
            />
            <TextField
              margin="dense"
              label="Edad"
              name="age"
              fullWidth
              value={formData.age}
              onChange={handleChange}
            />
            <TextField
              margin="dense"
              label="Correo"
              name="email"
              fullWidth
              value={formData.email}
              onChange={handleChange}
            />
            <TextField
              margin="dense"
              label="Teléfono"
              name="phone"
              fullWidth
              value={formData.phone}
              onChange={handleChange}
            />
            <DialogActions>
              <Button onClick={handleClose} color="secondary">
                Cancelar
              </Button>
              <Button type="submit" color="primary">
                Agregar Usuario
              </Button>
            </DialogActions>
          </form>
        </DialogContent>
      </Dialog>
      <div id='tablediv'>
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>ID</TableCell>
                <TableCell>Nombre</TableCell>
                <TableCell align="right">Apellido</TableCell>
                <TableCell align="right">Edad</TableCell>
                <TableCell align="right">Correo</TableCell>
                <TableCell align="right">Teléfono</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {users.map((user) => (
                <TableRow key={user.id} sx={{ '&:last-child td, &:last-child th': { border: 0 } }}>
                  <TableCell component="th" scope="row">
                    {user.id}
                  </TableCell>
                  <TableCell>{user.firstName}</TableCell>
                  <TableCell align="right">{user.lastName}</TableCell>
                  <TableCell align="right">{user.age}</TableCell>
                  <TableCell align="right">{user.email}</TableCell>
                  <TableCell align="right">{user.phone}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </div>
    </div>
  );
}
