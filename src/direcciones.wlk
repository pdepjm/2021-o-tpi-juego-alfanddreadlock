import wollok.game.*
import ConfigGen.*
import Obstaculos.*
/*
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
*/
const izquierda= new Izq()
const derecha = new Der()
const arriba = new Arriba()
const abajo = new Abajo()

object direcciones{
	const direccionesPosibles = [izquierda,derecha,arriba,abajo]
	method direccionesAldeanas(posicion) = direccionesPosibles.map{direccion=>direccion.proximaPosicion(posicion)}
}

class Direccion{
	//const property direcciones = [izquierda,arriba,abajo,derecha]
	var property siguientePosicion=null
	var property direccionActual=null
	
	method movemePara(personaje,posicion){
		siguientePosicion = self.proximaPosicion(posicion)
		if(self.esPosible(posicion)){
			personaje.position(siguientePosicion)
		}
	}
	
	method esPosible(posicion){
		return obstaculosGenerales.posiciones().contains(self.proximaPosicion(posicion)).negate()
	}
	
	method proximaPosicion(posicion)
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
	override method proximaPosicion(posicion){
		return posicion.left(1) 
	}
}
class Der inherits Direccion{
	override method proximaPosicion(posicion){
		return posicion.right(1)
	}
}
class Arriba inherits Direccion{
	override method proximaPosicion(posicion){
		return posicion.up(1)
	}
}
class Abajo inherits Direccion{
	override method proximaPosicion(posicion){
		return posicion.down(1)
	}
}

