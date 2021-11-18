# Bomberman del Subdesarrollo

##	α n dread		(AlfaNDread)

## Capturas

(agregar)

## Reglas de Juego / Instrucciones
Es como el Bomberman.
El objetivo es eliminar a todos los monstruos. Estos atacan, te hacen perder y volver al inicio.
Para eliminarlos, se deben colocar bombas que al explotar luego de 2 segundos lo eliminen.
Las bombas pueden eliminarnos. Todos los personajes tienen 3 vidas.

## Respuestas teóricas

Polimorfismo: ¿Cuál es el mensaje polimórfico? ¿Qué objetos lo implementan? ¿Qué objeto se aprovecha de ello?
El mensaje polimorfico es poderPosible.aparecer(). Este mensaje lo entiende tanto el Fuego como la BombaExtra.
Los objetos que se aprovechan de este polimorfismo son aquellos que sean de la class obstaculoRompible, 
donde el poderPosible que van a generar es random, siendo asi que sea cual sea el poder que se genere debe 
entender el mensaje.

Colecciones: ¿Qué operaciones de colecciones se utilizan? ¿Usaron mensajes con y sin efecto? ¿Para qué?
¿La colección de tipos de desplazamientos?
Utilizamos principalmente anyOne y forEach. Tambien usamos all y map en casos puntuales. Utilizamos mensajes con
efecto para hacer las mecanicas de movimiento de distintos objetos del juego, por ejemplo, las babas. Utilizamos
mensajes sin efecto, por ejemplo, en los obstaculos: el metodo posiciones en obtaculosGenerales mapea las posiciones de los obstaculos.
Esta informacion nos sirve para que las direcciones puedan saber que posiciones estan ocupadas, y si esa lista contiene la posicion
a la que nos queremos mover. 

Clases: ¿Usan clases? ¿Por qué? ¿Dónde o cuándo se instancian los objetos?
Usamos clases para poder instanciar mas de un objeto que tenga el mismo comportamiento. Esto se puede ver tanto en los personajes, como en
en las bombas, las explosiones, los objetos agarrables, etc. Esto lo hacemos ya que si declarariamos como objeto, por ejemplo,
una bomba, cuando pusieramos una y luego intentaramos poner otra, al momento de pulsar la barra espaciadora la 1er bomba se 
teletransportaria a esta nueva posicion dado que los objetos son unicos. 

Herencia: ¿Entre quiénes y por qué? ¿Qué comportamiento es común y cuál distinto?
¿No tenemos?
Tenemos herencia en multiples clases, principalmente tenemos una clase general Personaje de la cual herendan tanto el bomberman
como los monstruos. Estas clases comparten atributos (position, image, vidas, etc.) y metodos (morir,perder,meLlevoPuesto,etc), pero
tambien tienen diferencias: si bien el bomberman al morir tambien desaparece del juego, en ese caso ademas se reinicia la partida. De la 
misma manera, si bien el monstruo al crearse tambien añade su visual al juego, tambien debe configurar su movimiento automatico.

Composición: ¿Qué objetos interactúan? ¿Dónde se delega? ¿Por qué no herencia?
Haciendo referencia al punto anterior, en los mounstruos decidimos usar herencia en vez de composicion ya que (ademas 
de compartir atributos y metodos) cada mounstruo tiene una unica identidad que no puede ser cambiada.