# iOS App - MVVM Clean + Combine + Coordinator

## Introducción
Este proyecto es una aplicación iOS desarrollada con SwiftUI, siguiendo la arquitectura MVVM Clean y el patrón de navegación Coordinator. Se ha utilizado Combine para la gestión reactiva de datos y se han implementado pruebas automatizadas con XCTest y Fastlane.

## Tecnologías Utilizadas
- **Xcode**: 16
- **Swift**: 5+
- **SwiftUI**: Para la interfaz de usuario declarativa.
- **iOS Mínimo**: 17
- **Combine**: Para manejar la reactividad y la comunicación entre capas.
- **Fastlane**: Para la automatización de pruebas.
- **XCTest**: Para pruebas unitarias.
- **Kingfisher**: Para la carga eficiente de imágenes.

## Demostración de la Aplicación

Puedes ver una demostración del funcionamiento de la aplicación en el siguiente video:

![preview](https://github.com/user-attachments/assets/951a7800-c2d0-4ae2-8d80-81fbb93a8f40)

## Arquitectura

El proyecto está basado en la arquitectura **MVVM Clean**, que separa claramente las responsabilidades de cada capa:

- **Model (M)**: Representa los datos y las estructuras del dominio.
- **View (V)**: Se encarga de la representación visual utilizando SwiftUI.
- **ViewModel (VM)**: Maneja la lógica de presentación y la transformación de datos para la vista.
- **Use Cases**: Separan la lógica de negocio en casos de uso reutilizables.
- **Repository**: Abstrae la capa de datos para desacoplar la obtención de información.

Esta arquitectura permite una mejor escalabilidad, modularidad y testabilidad.

## Patrones de Diseño Aplicados

### MVVM (Model-View-ViewModel)
- **ViewModels**: `HomeViewModel`, `DetailViewModel`, `MapViewModel` manejan la lógica de presentación.
- **Views**: `HomeView`, `DetailView`, `MapView` se encargan de la UI.

### Coordinator Pattern
- `AppCoordinator` gestiona la navegación de la aplicación, evitando que las vistas dependan directamente de la lógica de navegación.

### Factory Pattern
- `NavigationFactory.view(for:dependencies:)` centraliza la creación de vistas para evitar lógica repetitiva en la navegación.

### Repository Pattern
- `DishesRepository` encapsula la obtención de datos, desacoplando la capa de red.

### Use Case Pattern
- `GetDishesUseCase` introduce una capa de abstracción para la lógica de negocio, permitiendo testearla independientemente.

### Dependency Injection
- `AppDependencies` centraliza la inyección de dependencias, mejorando la modularidad y testabilidad.

## Elección de Combine sobre @Observable

Swift 5.9 introdujo `@Observable`, pero actualmente, Combine sigue siendo una mejor opción para aplicaciones que requieren compatibilidad con versiones anteriores de iOS.

| Año  | iOS Soportado | Recomendación |
|-------|--------------|-----------------|
| 2024  | iOS 13+ (aún hay usuarios en iOS 16) | Usar `ObservableObject` con `@StateObject` y `@EnvironmentObject`. |
| 2025  | iOS 15+ (pocos usuarios en iOS 16) | Evaluar si el porcentaje de usuarios en iOS 16 es bajo. |
| 2026  | iOS 17+ (iOS 16 casi desaparecido) | Migrar a `@Observable` para simplificar el código. |

En este proyecto, dado que la versión mínima es iOS 17, Combine sigue siendo una opción válida hasta que `@Observable` madure completamente.

## Librerías Utilizadas

- **Kingfisher**: Para carga eficiente de imágenes en SwiftUI.
- **Fastlane**: Para la automatización de pruebas.
- **XCTest**: Para la ejecución de pruebas unitarias.

## Servicio Web Utilizado

Para la obtención de datos, se utilizó la siguiente API:
```
https://demo8302872.mockable.io/recipes
```

## Pruebas Automatizadas

Se implementaron pruebas unitarias con XCTest y se integró Fastlane para su ejecución automática:

```
fastlane ios run_tests
```

Esto permite validar la funcionalidad del código de manera eficiente antes de desplegar cambios.

## Conclusión

Este proyecto sigue buenas prácticas de desarrollo con una arquitectura bien estructurada, aplicación de patrones de diseño adecuados y el uso de herramientas modernas como Combine, Fastlane y XCTest. Se priorizó la escalabilidad, testabilidad y modularidad para garantizar un código limpio y mantenible.


