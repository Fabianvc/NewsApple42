#import "NewsImageView.h"

@implementation NewsImageView

// Crear una caché estática para almacenar las imágenes
static NSCache *imageCache;

+ (void)initialize {
    if (self == [NewsImageView class]) {
        imageCache = [[NSCache alloc] init];
        imageCache.countLimit = 100; // Limitar el número de imágenes en caché
    }
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    // Establecer la imagen de placeholder inicialmente
    self.image = placeholder;

    // Verificar si la imagen ya está en la caché
    NSString *cacheKey = url.absoluteString;
    UIImage *cachedImage = [imageCache objectForKey:cacheKey];
    if (cachedImage) {
        // Si la imagen está en la caché, usarla directamente
        self.image = cachedImage;
        return;
    }

    // Si no está en la caché, descargar la imagen
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                  dataTaskWithURL:url
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
        // Manejar errores de red
        if (error) {
            NSLog(@"Failed to load image: %@", error.localizedDescription);
            return;
        }

        // Validar la respuesta HTTP
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200) {
            NSLog(@"Failed to load image: HTTP %ld", (long)httpResponse.statusCode);
            return;
        }

        // Validar los datos recibidos
        if (!data) {
            NSLog(@"Failed to load image: No data received");
            return;
        }

        // Crear la imagen descargada
        UIImage *downloadedImage = [UIImage imageWithData:data];
        if (!downloadedImage) {
            NSLog(@"Failed to load image: Invalid image data");
            return;
        }

        // Guardar la imagen en la caché
        [imageCache setObject:downloadedImage forKey:cacheKey];

        // Actualizar la imagen en el hilo principal
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = downloadedImage;
        });
    }];

    // Iniciar la tarea
    [task resume];
}

@end
