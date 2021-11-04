# Bomberman del Subdesarrollo

##	α n dread		(AlfaNDread)

## Capturas

(agregar)

## Reglas de Juego / Instrucciones
Es como el Bomberman.
El objetivo es eliminar a todos los monstruos. Estos atacan, te hacen perder y volver al inicio.
Para eliminarlos, se deben colocar bombas que al explotar luego de 2 segundos lo eliminen.
Las bombas pueden autoeliminarnos.

## Respuestas teóricas

Polimorfismo: ¿Cuál es el mensaje polimórfico? ¿Qué objetos lo implementan? ¿Qué objeto se aprovecha de ello?
Al configurar las colisiones mandamos el mensaje efecto() de manera polimorfca. En este caso puntual, el 
objeto que lo implementa sera el game.Los objetos que lo aprovechan son aquellos que pueden colisionar con 
el bomberman (carpincho, llama, baba y explosion).

Colecciones: ¿Qué operaciones de colecciones se utilizan? ¿Usaron mensajes con y sin efecto? ¿Para qué?
¿La colección de tipos de desplazamientos?
Utilizamos principalmente anyOne y forEach. Tambien usamos all y map en casos puntuales. Utilizamos mensajes con
efecto para hacer las mecanicas de movimiento de distintos objetos del juego, por ejemplo, las babas. Utilizamos
mensajes sin efecto en los obstaculos cuando el metodo posiciones en obtaculosGenerales mapea las posiciones de los obstaculos.

Clases: ¿Usan clases? ¿Por qué? ¿Dónde o cuándo se instancian los objetos?
Usamos clases para poder instanciar mas de un unico objeto del mismo tipo. Esto se puede ver en las mecanicas
de la llama ya que al escupir() instancia una nueva baba (un proyectil) y lo puede repetir las veces que queramos.

Herencia: ¿Entre quiénes y por qué? ¿Qué comportamiento es común y cuál distinto?
¿No tenemos?
Tenemos herencia en multiples clases, principalmente tenemos una clase general Personaje de que herencian tanto el bomberman
como los monstruos. Estas clases comparten atributos (position, image, vidas, etc.) y metodos (morir y perder). Donde mejor
se puede apreciar un comportamiento distinto es entre las clases Monstruo y MonstruoADistancia. Ambos caminan y tienen su efecto
pero el MonstruoADistancia debe tambien poder escupir, generando una baba.

Composición: ¿Qué objetos interactúan? ¿Dónde se delega? ¿Por qué no herencia?
Interactuan los personajes con las direcciones. Los personajes delegan su movimiento a las direcciones. Las direcciones
son objetos que no comparten atributos ni metodos con los personajes, por lo tanto no se herencia nada.