import wollok.game.*
import Obstaculos.*

const direccionesPermitidas = [izquierda,derecha,arriba,abajo]

class Direccion{
	
	
	method movemePara(personaje,posicion,cantidad){
		if(self.esPosible(posicion,cantidad)){
			personaje.position(self.proximaPosicion(posicion,cantidad))
			
		}
		personaje.direccionarVisual(self)
	}
	
	method esPosible(posicion,cantidad){
		return obstaculosGenerales.posiciones().contains(self.proximaPosicion(posicion,cantidad)).negate()
	}
	method puedeSeguir(position,cantidad) = (0..cantidad-1).all{i=>self.esPosible(position,i)}
	method proximaPosicion(posicion,cantidad)
}

object izquierda inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.left(cantidad) 
	}
	method nombre() = "Izquierda"
}
object derecha inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.right(cantidad)
	}
	method nombre() = "Derecha"
}
object arriba inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.up(cantidad)
	}
	method nombre() = "Arriba"
}
object abajo inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.down(cantidad)
	}
	method nombre()= "Abajo"
}