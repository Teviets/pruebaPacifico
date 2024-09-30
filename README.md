# Integración de API

### Creado por

Sebastian Estrada

## Descripción

Este proyecto implementa una integración con una API externa utilizando un entorno NodeJS. La aplicación envía solicitudes HTTP a la API, procesa las respuestas y maneja los datos de manera adecuada. El proyecto incluye ejemplos de solicitudes `GET` y `POST`.

## Requisitos

Antes de ejecutar este proyecto, asegúrate de tener instalado Node y las siguientes bibliotecas:

### 1. **Bibliotecas de Node necesarias**

Para visualizar la pagina se requieren las siguientes dependencias:

- **@emotion/react**
- **@emotion/styled**
- **@mui/material**
- **@testing-library/jest-dom**
- **@testing-library/react**
- **@testing-library/user-event**
- **react**
- **react-dom**
- **react-scripts**
- **web-vitals**

Para instalar las dependencias, ejecuta el siguiente comando en la carpeta api-integration:

```bash
npm i
```

### API utilizada

Este proyecto utiliza la API de `https://dummyjson.com/` para realizar operaciones:

- GET: Obtiene los usuarios
- POST: Publica usuarios


### Uso

Para correr en local la pagina se necesita estar en la ubicacion `api-integration` y correr este comando:

```bash
npm run start
```
