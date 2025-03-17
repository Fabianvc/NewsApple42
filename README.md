# News App

Una aplicación de iOS para mostrar las últimas noticias utilizando `UICollectionView` con `Compositional Layout` y `Diffable Data Source`. La aplicación sigue principios de diseño limpio y modularidad para facilitar el mantenimiento y la escalabilidad.

## Características

- **Lista de noticias**: Muestra una lista de noticias con título, fecha y una imagen.
- **Diseño moderno**: Utiliza `UICollectionViewCompositionalLayout` para un diseño flexible y adaptativo.
- **Actualización en tiempo real**: Los datos se actualizan dinámicamente utilizando `UICollectionViewDiffableDataSource`.
- **Detalle de noticias**: Permite navegar a una vista de detalle para leer la noticia completa.
- **Soporte para errores**: Muestra alertas en caso de errores al cargar las noticias.
- **Pull-to-Refresh**: Actualiza las noticias al deslizar hacia abajo.

## Requisitos

- **iOS 13** o superior.
- **Xcode 11** o superior.
- Conexión a internet para cargar las noticias.
- Una API Key válida de [NewsAPI](https://newsapi.org/).
- Abre el archivo APIConstants.swift en el proyecto.
- Reemplaza el valor de apiKey con tu API Key
