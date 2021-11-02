import wollok.game.*
import ConfigGen.*
import Obstaculos.*
import NPCs.*

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
const direccionesPermitidas = [izquierda,derecha,arriba,abajo]
/*object direcciones{
	const direccionesPosibles = [izquierda,derecha,arriba,abajo]
	method direccionesAldeanas(posicion) = direccionesPosibles.map{direccion=>direccion.proximaPosicion(posicion)}
}*/

class Direccion{
	//const property direcciones = [izquierda,arriba,abajo,derecha]
	var property siguientePosicion=null
	var property direccionActual=null
	
	method movemePara(personaje,posicion,cantidad){
		siguientePosicion = self.proximaPosicion(posicion,cantidad)
		if(self.esPosible(posicion,cantidad)){
			personaje.position(siguientePosicion)
		}
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
}
class Der inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.right(cantidad)
	}
}
class Arriba inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.up(cantidad)
	}
}
class Abajo inherits Direccion{
	override method proximaPosicion(posicion,cantidad){
		return posicion.down(cantidad)
	}
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
	
	method obstacule(objeto){//Dice si en la próxima posición hay un obstaculo.
		nextPosition=direction.next(objeto)
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

class Monstruo{
	var property imageI = null
	var property imageD = null
	var property image = null
	var property position = null
	method imageI()=imageI
	method imageD()=imageD
	method posicion()=position
	method imageActual(imageActual){image=imageActual}
	method posicionar(posicion){position=posicion}
	method matar(){//Hace perder a bomberman
		if(self.posicion()==bomberman.posicion()){
			bomberman.perder()
		}
	}
	method morir(){
		game.removeVisual(self)
	}
}

const carpincho = new Monstruo (imageI = "carpinchoI.png",imageD = "carpinchoD.png",image="carpinchoI.png", position = game.at(12,12))
const direccionamientoCarpincho = new Direccionamiento(direction=left,nextPosition=left.next(carpincho))
