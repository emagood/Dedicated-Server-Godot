# [ing]
# DVL
# User Management Project with Thot-p2p

This project implements a user management system using Godot Engine and the ENet library, tcp and websocket, for client-server communication. The system allows the creation, modification, and deletion of users with credential verification, caching, and change history logging.

## Features

- **Create Users**: Allows you to create new users with a username, identifier and password.
- **Modify Users**: Allows you to update the username and/or password of verified users.
- **Delete Users**: Allows you to remove users from the system.
- **Authentication**: Verify the user's credentials before allowing modifications.
- **Cache**: Use a cache system to improve performance.
- **History Log**: Keeps a history of changes (creations, modifications, errors) with a record on file.

## Main Archives

- User.: Defines the 'User' class to handle user information.
- UserSearcher: Implements user search in the file.
- UserArrayManager: Handles the creation, modification, and deletion of users, as well as cache management.
- ChangeHistory.g: Maintains a change log with the ability to upload and save to archive.



# [esp]
# DVL
# Proyecto de Gestión de Usuarios con Thot-p2p

Este proyecto implementa un sistema de gestión de usuarios utilizando Godot Engine y la biblioteca ENet , tcp y websocket , para la comunicación cliente-servidor. El sistema permite la creación, modificación y eliminación de usuarios con verificación de credenciales, almacenamiento en caché y registro de historial de cambios.

## Funcionalidades

- **Crear Usuarios**: Permite crear nuevos usuarios con nombre de usuario, identificador y contraseña.
- **Modificar Usuarios**: Permite actualizar el nombre de usuario y/o contraseña de usuarios verificados.
- **Eliminar Usuarios**: Permite eliminar usuarios del sistema.
- **Autenticación**: Verifica las credenciales del usuario antes de permitir modificaciones.
- **Caché**: Utiliza un sistema de caché para mejorar el rendimiento.
- **Registro de Historial**: Mantiene un historial de cambios (creaciones, modificaciones, errores) con registro en archivo.

## Tecnologías Utilizadas

- **Godot Engine 4.3**: Motor de juego utilizado para el desarrollo.
- **ENet**: Biblioteca para la comunicación cliente-servidor.
- **TCP**: 
- **WebSocket**:
- 
## Instalación

1. Clona este repositorio:
    ```sh
    git clone https://github.com/emagood/E-DataBase.git
    cd E-DataBase
    ```

2. Abre el proyecto en Godot Engine.

## Uso

1:Interactúa con el sistema:
    - Usa las funciones de creación, modificación y eliminación de usuarios a través de la interfaz del cliente.

## Archivos Principales

- User.: Define la clase `User` para manejar la información de los usuarios.
- UserSearcher.: Implementa la búsqueda de usuarios en el archivo.
- UserArrayManager.: Maneja la creación, modificación y eliminación de usuarios, así como la gestión de la caché.
- ChangeHistory.g: Mantiene un registro de cambios con capacidad para cargar y guardar en archivo.

## Proyecto Complementario

Este proyecto se utiliza para complementar el sistema de usuarios de otro proyecto. Puedes encontrar más detalles y colaborar en el proyecto complementario [aquí](https://github.com/emagood/SocketSyncLinker.git).

## Contribuciones

Las contribuciones son bienvenidas. Si deseas colaborar, por favor sigue los siguientes pasos:

1. Bifurca este repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva_caracteristica`).
3. Realiza tus cambios y haz commit (`git commit -am 'Agrega nueva característica'`).
4. Empuja tu rama (`git push origin feature/nueva_caracteristica`).
5. Abre un Pull Request.

## x no impelentado 
Implement an AES to encrypt data, AES data tends to have the same memory space in a Bytearray, that's useful since we save and load blocks
implementar un aes para cifrar los datos , los datos aes tienden a tener el mismo espacio de memoria en un bytearray , eso es útil ya que guardamos y cargamos bloques 

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.





 
