
#### Ejercicio 1 – Sonido

# En este ejercicio se comparan 3 tipos de sonido con diferentes técnicas:
# oscilograma, periodograma y espectrograma con las librerías de R seewave y tuneR.

### Parte A – Metadata

## 1) Levantar en R 3 sonidos
## 2) Muestre la página web origen de cada sonido y explique brevemente dequé trata. En el caso de habla, indique cuál frase se dice.

library(seewave)
library(tuneR)

# Sonido de un instrumento musical
# Tomo el sonido de un tambor
# Fuente: https://www.kaggle.com/datasets/soumendraprasad/musical-instruments-sound-dataset?resource=download
drum = readWave("data/sonidos/drum.wav")
play(drum)

# Un sonido genérico, como viento, lluvia, un automóvil, etc.
# Tomo el sonido del canto de un pájaro
# Fuente: https://www.kaggle.com/datasets/vinayshanbhag/bird-song-data-set
bird = readWave("data/sonidos/bird.wav")
play(bird)

# Un sonido de habla
# El audio dice: "Si esto sigue llegará día en que tenga que cambiar todos mis diamantes por una gallina"
# Fuente: https://www.kaggle.com/datasets/bryanpark/spanish-single-speaker-speech-dataset
speech = readWave("data/sonidos/speech.wav")
play(speech)

### Parte A – Oscilograma

## 1) Analizar la metadata de los sonidos

# Sonido 1 - Instrumento musical
drum
# Cantidad de muestras: 233280
length(drum)
# Duración (en segundos): 9.72
duration(drum)
# Muestreo (samples por segundo): 24000 Hz
drum@samp.rate
# Mono o estéreo: Stereo

# Sonido 2 - Sonido genérico - Pájaro
bird
# Cantidad de muestras: 66150
length(bird)
# Duración (en segundos): 3
duration(bird)
# Muestreo (samples por segundo): 22050 Hz
bird@samp.rate
# Mono o estéreo: Mono

# Sonido 3 - Sonido de habla
speech
# Cantidad de muestras: 151800
length(speech)
# Duración (en segundos): 6.88
duration(speech)
# Muestreo (samples por segundo): 22050 Hz
speech@samp.rate
# Mono o estéreo: Mono

## 2) Dibuje el oscilograma de cada sonido

x11() ; oscillo(drum)
x11() ; oscillo(bird)
x11() ; oscillo(speech)

## 3) Realice un zoom hasta ver una onda

x11() ; oscillo(drum, from=0.5, to=0.57)
x11() ; oscillo(bird, from=0.22, to=0.222)
x11() ; oscillo(speech, from=0.3, to=0.302)

## 4) Baje la amplitud y escuche el nuevo sonido.
##    Dibuje el oscilograma del nuevo sonido. Compare los valores de amplitud (eje Y) con los del sonido original.

# Con el parámetro level controlamos el volumen: 1 significa que no modificamos el volumen, números menores bajan el volumen.
drum_menosVolumen = normalize(drum, unit='16', level=0.1)
bird_menosVolumen = normalize(bird, unit='16', level=0.1)
speech_menosVolumen = normalize(speech, unit='16', level=0.1)

# Si hacemos play del sonido original y el de menos volumen, podemos ver que efectivamente funcionó
play(drum)
play(drum_menosVolumen)
play(bird)
play(bird_menosVolumen)
play(speech)
play(speech_menosVolumen)

# Grafico en un mismo gráfico cada par de sonidos: el original y el del volumen bajo

x11() ; par(mfrow = c(2, 1))
oscillo(drum)
axis(side = 2, las = 2)
title('Tambor - Volumen original')
oscillo(drum_menosVolumen)
axis(side = 2, las = 2)
title('Tambor - Volumen bajo')

x11() ; par(mfrow = c(2, 1))
oscillo(bird)
axis(side = 2, las = 2)
title('Pájaro - Volumen original')
oscillo(bird_menosVolumen)
axis(side = 2, las = 2)
title('Pájaro - Volumen bajo')

x11() ; par(mfrow = c(2, 1))
oscillo(speech)
axis(side = 2, las = 2)
title('Habla - Volumen original')
oscillo(speech_menosVolumen)
axis(side = 2, las = 2)
title('Habla - Volumen bajo')

# El primer sonido es el único que es estéreo.
# En ese se ve en los ejes Y que el sonido de volumen bajo toma valores mucho menores que el sonido original.
# El segundo y tercer sonido son mono.
# Seguramente por eso es que los ejes Y de los sonidos originales están acotados entre -1 y 1.
# Pero los sonidos de volumen bajo ya no tienen ese límite, más allá de que efectivamente el volumen bajó cuando hacemos play de los sonidos.

### Parte B – Periodograma-Espectrograma

## 1) Dibuje el periodograma de cada sonido.

x11() ; spec(drum) ; axis(side=2, las=2) ; title(main="Tambor")
x11() ; a = periodogram(bird) ; plot(a) ; title(main="Pájaro")
x11() ; a = periodogram(speech) ; plot(a) ; title(main="Habla")

## 2) ¿En qué rangos se encuentran las frecuencias?

# El tambor está aproximadamente entre 0kHz y 3kHz
# El pájaro está aproximadamente entre 2kHz y 6.5kHz
# El habla está aproximadamente entre 0kHz y 2kHz

## 3) Muestre el espectrograma de cada sonido.

# Dibujo el espectrograma:
x11() ; spectro(drum) ; title(main="Tambor")
# Dibujo la versión zoomeada para ver la parte interesante:
x11() ; spectro(drum, flim=c(0,0.5), osc=T) ; title(main="Tambor")

x11() ; spectro(bird) ; title(main="Pájaro")
x11() ; spectro(bird, flim=c(2,8), osc=T) ; title(main="Pájaro")

x11() ; spectro(speech) ; title(main="Habla")
x11() ; spectro(speech, flim=c(0,3), osc=T) ; title(main="Habla")

## 4) Considere uno de los sonido y fíltrelo con un filtro pasa-bajo y con un filtropasa-alto.
##    Muestre el espectrograma resultante de cada sonido filtrado.

# Pasa bajo
drumPB = ffilter(bird, to=200, output="Wave")
drumPB = normalize(drumPB, unit='16')
x11() ; spectro(drumPB, flim=c(0,0.5)) ; title(main = "Tambor con filtro pasa bajos")

# Pasa alto
drumPA = ffilter(bird, from=200, output="Wave")
drumPA = normalize(drumPA, unit='16')
x11() ; spectro(drumPA, flim=c(0,0.5)) ; title(main = "Tambor con filtro pasa altos")

### Parte C – Análisis

## 1) Según el espectrograma de cada sonido, ¿en qué rangos se encuentran las frecuencias?

# La mayor parte de la intensidad del tambor está aproximadamente entre 0kHz y 0.5kHz
# La mayor parte de la intensidad del pájaro está aproximadamente entre 2kHz y 7kHz
# La mayor parte de la intensidad del habla está aproximadamente entre 0kHz y 3kHz

## 2) En el caso del sonido de habla, muestre el oscilograma y el espectrograma uno debajo
##    del otro y trate de identificar dónde se está diciendo cada palabra.

x11() ; spectro(speech, flim=c(0,3), osc=T) ; title(main="Habla")

# No voy a poder reconocer todas las palabras porque son demasiadas, pero miro algunas secciones.

# Frase "si esto sigue"
speech_cortado = window(speech, start = 1000, end = 25000)
play(speech_cortado)
x11() ; spectro(speech_cortado, flim=c(0,3), osc=T) ; title(main="Habla (cortado)")

# Frase "diamantes por una"
speech_cortado = window(speech, start = 76000, end = 95000)
play(speech_cortado)
x11() ; spectro(speech_cortado, flim=c(0,3), osc=T) ; title(main="Habla (cortado)")
# La palabra "diamantes" es todo un contínuo en el espectrograma.
# Antes del la "p" del "por" se ve claramente un silencio.
# Después del "por" hay otro claro silencio, para que aparezca al final el "una".


## 3) En el caso del sonido de habla, trate de identificar silencios o consonantes en
##    el espectrograma o el oscilograma.

# Frase "diamantes por una"
speech_cortado = window(speech, start = 76000, end = 95000)
play(speech_cortado)
x11() ; spectro(speech_cortado, flim=c(0,3), osc=T) ; title(main="Habla (cortado)")
# Antes y después de la palabra "por" se ven claramente lo silencios.

# Frase "una gallina"
speech_cortado = window(speech, start = 92000, end = 107000)
play(speech_cortado)
x11() ; spectro(speech_cortado, flim=c(0,3), osc=T) ; title(main="Habla (cortado)")
# Antes de la "g" de gallina se un silencio.

# Palabra "esto"
speech_cortado = window(speech, start = 8500, end = 14100)
play(speech_cortado)
x11() ; spectro(speech_cortado, flim=c(0,3), osc=T) ; title(main="Habla (cortado)")
# Esto es interesante porque es solamente la palabra "esto", y se ve claramente un silencio entre
# "es" y "to" por la consonante "t". La boca tiene que posicionarse para pronunciar la consonante
# explosiva "t", y por eso se produce ese silencio que es impercetible por el oído.

## 4) Compare los 3 espectrogramas y saque alguna conclusión.

x11() ; spectro(drum, flim=c(0,0.5), osc=T) ; title(main="Tambor")
x11() ; spectro(bird, flim=c(2,8), osc=T) ; title(main="Pájaro")
x11() ; spectro(speech, flim=c(0,3), osc=T) ; title(main="Habla")

# En el espectrogrma del tambor se ve claramente cada uno de los golpes del tambor, por ser un
# sonido explosivo. El golpe es muy fuerte y luego decae con el tiempo, hasta que llega el próximo
# golpe. Las frecuencias son bajas porque es un sonido grave.

# El espectrograma del pájaro muestra frecuencias mucho más altas, lo cual tiene sentido porque
# el canto es muy agudo. Se ven sonidos de corta duración, cada uno muy bien separado del anterior.
# Estos serían cada uno de los "tweets" del pájaro. Esto se diferencia mucho de otro tipo de ruidos
# ambiente, como puede ser la lluvia, donde no hay sonidos delimitados sino que el espectrograma es
# una gran mancha contínua sin silencios.

# El espectrograma del habla también está bastante centrado en frecuencias bajas. El hombre tiene una
# voz más bien grave. Se pueden ver algunos silencios, similar al pájaro, pero mucho menos delimitados.
# Comparado al pájaro, el sonido es más contínuo.

#### Ejercicio 1 – Imágenes

# En este ejercicio se realizan aplicaciones de Machine Learning en imágenes con R.
# Primero se analiza un Análisis de Componentes Principales y luego una Segmentación.

### Parte A – PCA

## 1) Elegir una imagen pública de formato jpg. No pueden aparecer personas en la imagen y la misma debe
##    respetar los principios éticos y de confidencialidad básicos. No utilizar imágenes usadas en clase.
##    Mostrar la imagen e indicar la página web origen.

library(jpeg)

# La imagen fue sacada de:
# https://www.bbc.com/mundo/noticias-55481251
imagen = readJPEG("data/imagenes/space.jpg")
x11() ; plot(as.raster(imagen))
dim(imagen)

## 2) ¿Cuáles son las dimensiones de la imagen?

dim(imagen)
# La imagen tiene dimensiones 549x976x3.

## 3) Realizar un PCA de la imagen.

r = imagen[,,1] # Rojo
v = imagen[,,2] # Verde
a = imagen[,,3] # Azul
base = data.frame(r,v,a)
dim(imagen)
dim(base)
pca = prcomp(base, center=FALSE)

# Tomo las primeras  componentes ppales y vuelvo a pasar al espacio original
cantidad_componentes_ppales = 30
original = pca$x[,1:cantidad_componentes_ppales]%*%t(pca$rotation[,1:cantidad_componentes_ppales])
# Normalizo los valores de 0 a 1 porque me quedaron fuera de rango
originalN = ( original - min(original) ) / ( max(original) - min(original) )
dim(original)
originalI = array(originalN, dim=c(549, 976, 3))

# Muestro las dos imágenes, la original y la de las componentes principales
x11() ; plot(as.raster(originalI)) ; title(sprintf("Imagen con %d componentes ppales", cantidad_componentes_ppales))
x11() ; plot(as.raster(imagen)) ; title("Imagen original")

## 4) Reconstruir la imagen usando 2 cantidades de componentes principales y mostrar ambas imágenes.

# Tomo las primeras 40 componentes ppales y vuelvo a pasar al espacio original
cantidad_componentes_ppales = 40
original = pca$x[,1:cantidad_componentes_ppales]%*%t(pca$rotation[,1:cantidad_componentes_ppales])
# Normalizo los valores de 0 a 1 porque me quedaron fuera de rango
originalN = ( original - min(original) ) / ( max(original) - min(original) )
dim(original)
originalI = array(originalN, dim=c(549, 976, 3))

# Repito exactamente lo mismo pero con 10 componentes ppales
cantidad_componentes_ppales2 = 10
original2 = pca$x[,1:cantidad_componentes_ppales2]%*%t(pca$rotation[,1:cantidad_componentes_ppales2])
# Normalizo los valores de 0 a 1 porque me quedaron fuera de rango
original2N = ( original2 - min(original2) ) / ( max(original2) - min(original2) )
dim(original2)
original2I = array(original2N, dim=c(549, 976, 3))

# Muestro las tres imágenes, la original y las dos PCA
x11() ; plot(as.raster(originalI)) ; title(sprintf("Imagen con %d componentes ppales", cantidad_componentes_ppales))
x11() ; plot(as.raster(original2I)) ; title(sprintf("Imagen con %d componentes ppales", cantidad_componentes_ppales2))
x11() ; plot(as.raster(imagen)) ; title("Imagen original")

## 5) Grabar las 2 nuevas imágenes y comparar su peso de almacenamiento con respecto al de la imagen original.

writeJPEG(originalI,sprintf('data/imagenes/imagen_%d_comp_ppales.jpeg', cantidad_componentes_ppales))
writeJPEG(original2I,sprintf('data/imagenes/imagen_%d_comp_ppales.jpeg', cantidad_componentes_ppales2))
