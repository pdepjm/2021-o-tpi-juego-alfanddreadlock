import wollok.game.*
import ConfigGen.*
import Obstaculos.*

const izquierda= new Izq()
const derecha = new Der()
const arriba = new Arriba()
const abajo = new Abajo()
const direccionesPermitidas = [izquierda,derecha,arriba,abajo]

class Direccion{
	//const property direcciones = [izquierda,arriba,abajo,derecha]
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
	//method proximaDireccion(direccion){direccionActual=direccion}
	/*
	method direccionAlAzar()=direcciones.anyOne()
	method cambiarDireccion(){
		if (direccionActual==direcciones.head())
		direccionActual=derecha
		else direccionActual=izquierda
		return direccionActual
	}

	
	method moverAutomatico(personaje){
		if (self.esPosible(personaje)){
		personaje.posicionar(self.proximaPosicion(personaje))
		}else{
		self.cambiarDireccion()
		personaje.posicionar(self.proximaPosicion(personaje))
		}
	}
	*/
}
// No se me ocurrio otra forma de poder juntar la parte de left(1), right(1), etc. Si pudiesemos meter alguna logica asi directamente 
// en Direccion, podriamos tener solo const izquierda = new Direccion(dir = left) (O algo por el estilo)

class Izq inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.left(cantidad) 
	}
	method nombre() = "Izquierda"
}
class Der inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.right(cantidad)
	}
	method nombre() = "Derecha"
}
class Arriba inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.up(cantidad)
	}
	method nombre() = "Arriba"
}
class Abajo inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.down(cantidad)
	}
	method nombre()= "Abajo"
}

