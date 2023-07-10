library(seewave)
library(tuneR)

#### Ejercicio 1 – Sonido

### Parte A – Metadata

## 1) Levantar en R 3 sonidos
## 2) Muestre la página web origen de cada sonido y explique brevemente dequé trata. En el caso de habla, indique cuál frase se dice.

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
# El audio dice: "The food was tasty but it should be less salty"
# La traducción es: "La comida era sabrosa pero debería ser menos salada"
# Fuente: https://www.kaggle.com/datasets/imsparsh/audio-speech-sentiment
speech = readWave("data/sonidos/speech.wav")
play(speech)
