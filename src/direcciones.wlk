import wollok.game.*
import ConfigGen.*
import Obstaculos.*

object izquierda {
	var property siguientePosicion = null
	method proximaPosicion(posicionActual) = posicionActual.left(1)
	method esPosible(posicion){
		siguientePosicion = self.proximaPosicion(posicion)
		return obstaculosGenerales.posiciones().contains(siguientePosicion).negate()
	}
}

object derecha {
	var property siguientePosicion = null
	method proximaPosicion(posicionActual) = posicionActual.right(1)
	method esPosible(posicion){
		siguientePosicion = self.proximaPosicion(posicion)
		return obstaculosGenerales.posiciones().contains(siguientePosicion).negate()
	}
}

object arriba{
	var property siguientePosicion = null
	method proximaPosicion(posicionActual) = posicionActual.up(1)
	method esPosible(posicion){
		siguientePosicion = self.proximaPosicion(posicion)
		return obstaculosGenerales.posiciones().contains(siguientePosicion).negate()
	}
}
object abajo{
	var property siguientePosicion = null
	method proximaPosicion(posicionActual) = posicionActual.down(1)
	method esPosible(posicion){
		siguientePosicion = self.proximaPosicion(posicion)
		return obstaculosGenerales.posiciones().contains(siguientePosicion).negate()
	}
}