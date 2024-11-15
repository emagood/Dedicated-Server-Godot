# Proyecto de Gestión de Usuarios con ENet

Este proyecto implementa un sistema de gestión de usuarios utilizando Godot Engine y la biblioteca ENet para la comunicación cliente-servidor. El sistema permite la creación, modificación y eliminación de usuarios con verificación de credenciales, almacenamiento en caché y registro de historial de cambios.

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


## Instalación

1. Clona este repositorio:
    ```sh
    git clone [https://github.com/tu_usuario/tu_proyecto.git](https://github.com/emagood/net-server-data_base-godot.git)
    cd tu_proyecto
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

Este proyecto se utiliza para complementar el sistema de usuarios de otro proyecto. Puedes encontrar más detalles y colaborar en el proyecto complementario [aquí](https://github.com/emagood/Enet-Godot-Multi-User.git).

## Contribuciones

Las contribuciones son bienvenidas. Si deseas colaborar, por favor sigue los siguientes pasos:

1. Bifurca este repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva_caracteristica`).
3. Realiza tus cambios y haz commit (`git commit -am 'Agrega nueva característica'`).
4. Empuja tu rama (`git push origin feature/nueva_caracteristica`).
5. Abre un Pull Request.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.





 
