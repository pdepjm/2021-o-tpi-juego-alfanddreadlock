import wollok.game.*
import ConfigGen.*
import Obstaculos.*

object izquierda {
	method ubicar(objeto)=objeto.posicion().left(1)
	}
object derecha {
	method ubicar(objeto)=objeto.posicion().right(1)
	}
object abajo {
	method ubicar(objeto)=objeto.posicion().down(1)
	}
object arriba {
	method ubicar(objeto)=objeto.posicion().up(1)
	}
	
class Direccion{
	var property siguientePosicion=null
	var property direccionActual=null
	method proximaDireccion(direccion){direccionActual=direccion}
	method proximaPosicion(personaje){
		siguientePosicion=direccionActual.ubicar(personaje)
		return siguientePosicion
	}
	method esPosible(personaje){
		siguientePosicion = self.proximaPosicion(personaje)
	return obstaculosGenerales.posiciones().contains(siguientePosicion).negate()
	}
	
	method moverAutomatico(personaje){
		if (self.esPosible(personaje)){
		personaje.posicionar(self.proximaPosicion(personaje))
		}else{
			self.proximaDireccion(derecha)
			personaje.imageActual(personaje.imageD())
			personaje.posicionar(self.proximaPosicion(personaje))
		}
	}
}

class Monstruo{
	var property imageI = null
	var property imageD = null
	var property image = imageI
	var property position = null
	method imageI()=imageI
	method imageD()=imageD
	method posicion()=position
	method imageActual(imageActual){image=imageActual}
	method posicionar(posicion){position=posicion}
}

class MonstruoADistancia inherits Monstruo{
	method escupir(){
		const baba = new Baba()
		game.addVisual(baba)
		babaEnJuego.add(baba)
	}
}

class Baba{
	var property imageI = null
	var property imageD = null
	var property image = imageI
	var property position = null
	method posicion()=position
	method imageActual(imageActual){image=imageActual}
	method posicionar(posicion){position=posicion}
	
}
const carpincho = new Monstruo (imageI = "carpinchoI.png",imageD = "carpinchoD.png", position = game.at(12,2))
const direccionCarpincho = new Direccion (direccionActual=izquierda)
const llama = new MonstruoADistancia (imageI="llamaIzq.png",imageD="LlamaDer.png",position = game.at(9,8))
const direccionLlama = new Direccion (direccionActual=izquierda)

/* 
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

*/