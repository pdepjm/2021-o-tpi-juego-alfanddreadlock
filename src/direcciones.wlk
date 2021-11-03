import wollok.game.*
import ConfigGen.*
import Obstaculos.*

const direccionesPermitidas = [izquierda,derecha,arriba,abajo]

class Direccion{
	
	var property siguientePosicion=null
	var property direccionActual=null
	
	method movemePara(personaje,posicion,cantidad){
		siguientePosicion = self.proximaPosicion(posicion,cantidad)
		if(self.esPosible(posicion,cantidad)){
			personaje.position(siguientePosicion)
		}
		//personaje.direccionar(self)
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
//Versión de Movimiento de Ger
object left {
	method next(objeto)=objeto.posicion().left(1)
	}
object rigth {
	method next(objeto)=objeto.posicion().right(1)
	}
object down {
	method next(objeto)=objeto.posicion().down(1)
	}
object up {
	method next(objeto)=objeto.posicion().up(1)
	}
	
class Direccionamiento{
	var nextPosition
	var direction
	const directions=[rigth,left,up,down]
	method direccion()=direction
	method posicion(personaje)=personaje.posicion()
	method isPossible(proxPosicion) = obstaculosGenerales.posiciones().contains(proxPosicion).negate()

	method moveTo(objeto,direccion){//Mover un personaje, una posición en la dirección elegida.
		nextPosition=direction.next(objeto)
		if (self.isPossible(nextPosition))
		{
		objeto.posicionar(nextPosition)
		}
	}
	
	method obstacule(personaje){//Dice si en la próxima posición hay un obstaculo.
		nextPosition=direction.next(personaje)
		return self.isPossible(nextPosition)
	}
	
	method otherDirection(){//Elige otra dirección al azar
		direction=directions.anyOne()		
}

	method automatic(personaje){//un método de direccionamiento aleatorio para el personaje elegido
		self.otherDirection()
		self.moveTo(personaje,direction)
		if(self.obstacule(personaje))
		{
		self.otherDirection()
		self.moveTo(personaje,direction)
		}
	}
}


