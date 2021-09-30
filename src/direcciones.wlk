import wollok.game.*
import ConfigGen.*

object izquierda {
	method proximaPosicion(posicionActual) = posicionActual.left(1) 
	method nombre() = "izquierda"
}

object derecha {
	method proximaPosicion(posicionActual) = posicionActual.right(1) 
	method nombre() = "derecha"
}

object arriba{
	method proximaPosicion(posicionActual) = posicionActual.up(1)
	method nombre() = "arriba"
}
object abajo{
	method proximaPosicion(posicionActual) = posicionActual.down(1)
	method nombre() = "abajo"
}
