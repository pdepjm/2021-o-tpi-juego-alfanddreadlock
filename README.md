# No Name (BomberPlagioMan?)

##	α n dread		(AlfaNDread)

## Capturas

(agregar)

## Reglas de Juego / Instrucciones
Es como el Bomberman.
Se debe llegar a la meta (punto objetivo). Hay monstruos que si te tocan, te hacen perder y volver al inicio.
Para eliminarlos, se deben colocar bombas que al explotar luego de 2 segundos lo eliminen.
Las bombas pueden autoeliminarnos.

## Respuestas teóricas

Polimorfismo: ¿Cuál es el mensaje polimórfico? ¿Qué objetos lo implementan? ¿Qué objeto se aprovecha de ello?
Pueden variar su imágen, su desplazamiento, su velocidad,
y su objetivo es tocar al personaje para perder la partida. ¿Los Lanzamientos se aprovechan de ello?

Colecciones: ¿Qué operaciones de colecciones se utilizan? ¿Usaron mensajes con y sin efecto? ¿Para qué?
¿La colección de tipos de desplazamientos?
La class de Monstruos debería tener una lista de desplazamientos disponible,
y según el monstruo que se crea, se asigna un tipo de desplazamiento.

Clases: ¿Usan clases? ¿Por qué? ¿Dónde o cuándo se instancian los objetos?
Las usamos porque varios objetos tienen las mismas características,
o por si en el futuro queremos crear más objetos con las mismas características.
Se instancian al perder una vida, o empezar otro nivel.

Herencia: ¿Entre quiénes y por qué? ¿Qué comportamiento es común y cuál distinto?
¿No tenemos?

Composición: ¿Qué objetos interactúan? ¿Dónde se delega? ¿Por qué no herencia?
El bomberman tira una bomba, que despide fuego
el fuego puede tocar al bomberman o al monstruo, o a varios al mismo tiempo.