import wollok.game.*
import direcciones.*
import ConfigGen.*
import Obstaculos.*


object bomberman{
	// esto seria para intentar lograr movimiento cuando el bomberman se mueve: const property movDerecha = ["bombermanDer1.png","bombermanDer2.png","bombermanDer3.png","bombermanDer4.png","bombermanDer5.png","bomberman.png"]
	var property image = "bomberman.png"
	var property position = game.at(0,0)
	const property esPP = true
	var bombasDisponibles = 1
	const bombasPuestas = []
	var alcance = 1
	var vidas = 3
	
	method moverPara(direccion) {
		direccion.movemePara(self,position,1) //las direcciones son quienes se encargan de mover al personaje
	}
	
	method ponerBomba(){
		self.recuperarBombas()
		if(bombasDisponibles>0){
			bombasPuestas.add(new Bomba(position = position))
			bombasDisponibles -=1
			game.addVisual(bombasPuestas.last())
			bombasPuestas.last().explotar(alcance)
		}
		else{
			game.say(self, "Bombas Insuficientes")
		}
	}
	method recuperarBombas(){
		bombasPuestas.forEach{bomba=>if(bomba.exploto()){
				bombasPuestas.remove(bomba)
				bombasDisponibles+=1
		}}
	}
	method sumarBomba(){bombasDisponibles+=1}
	method expandirAlcance(){alcance+=1}

	method perder(){ 
		vidas-=1
		if(vidas<0){
			self.morir()
		}
	}
	method morir(){
		game.removeVisual(self)
	}
	method modificarImagen(imagen){
		image = imagen
	}
}







class Explosion{
	var property image = "Explosion0.png"
	var property position = null
	var indice = 1
	const explosionesVinculadas=[]
	method mostrar(alcance){
		explosionesVinculadas.add(self)
		(1..alcance).forEach{i=>direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,i)}} //se podria hacer un game.schedule para que se muestre como animacion??
		//alcance.times{i=>direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,i)}} //INTENTO 1 -> al parecer la "i" no va aumentando
		explosionesVinculadas.forEach{explosion => self.configurarExplosion(explosion)}
		game.schedule(1500,{self.finDeExplosion()})
	}
	method configurarExplosion(explosion){
		game.addVisual(explosion)
		game.onCollideDo(explosion,{elemento=>elemento.perder()})
	}
	/*method controlDeAlcance(){
		direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,indice)}
		indice+=1
	} INTENTO2 */ 
	method expandirse(direccion,cantidad){
		if(direccion.puedeSeguir(position,cantidad)){
			//if (direccion.esPosible(position,cantidad)){
				explosionesVinculadas.add(new ExtensionDeExplosion(position = direccion.proximaPosicion(position,cantidad))) 
			//}
			/*else{
				explosionesVinculadas.add(new ObjetoInvisible(direccion.proximaPosicion(position,cantidad)))
			}*/ //ESTO ME ESTA ROMPIENDO
		}
		else{indice+=1}
	}
	method finDeExplosion(){
		explosionesVinculadas.forEach{explosion => game.removeVisual(explosion)}
	}
	/*
	method expansionChFinal(){
			fuegoPuedeIrPara = direcciones.direccionesAldeanas(position)
			fuegoPuedeIrPara.forEach{posicion=>espaciosOcupados.add(new ObjetoInvisible(position=posicion))}
			espaciosOcupados.forEach{objetoInvisible => game.addVisual(objetoInvisible)}
	}*/
}
class ExtensionDeExplosion{
	const property esPP = false
	const property position = null
	method image() = "Explosion0.png"
}

class ObjetoInvisible{
	const property position = null
}








class Personaje{ //Ya que hay cosas repetidas tanto en los mounstruos como en el bomberman, todavia esta clase no se usa
	var property image = null
	var property position = null
	var vidas = 3
	method perder(){ 
		vidas-=1
		if(vidas<0){
			self.morir()
		}
	}
	method morir(){
		game.removeVisual(self)
	}
	method modificarImagen(imagen){
		image = imagen
	}
}
/* 
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
*/
/* object llama{
	var property image = "LlamaIzq.png"
	var property direccion = "izquierda"
	var property position = game.at(9,8)
	var property posicionAnterior = game.at(0,0)
	var property posicionSiguiente = game.at(0,0)

	method caminar(){
		if (direccion=="izquierda"){
			self.caminarAIzquierda()
			}else{
		self.caminarADerecha()
		}
	}
	method caminarAIzquierda(){
		if (direccion == "izquierda"){
			image = "LlamaIzq.png"
			posicionAnterior = position
			posicionSiguiente = izquierda.proximaPosicion(position)
		if(obstaculosGenerales.posiciones().contains(posicionSiguiente)){
			direccion = "derecha"
			self.caminarADerecha()
				}else{
				position = posicionSiguiente 
			}
		}
	}
	
	method caminarADerecha(){
		if (direccion == "derecha"){
			image = "LlamaDer.png"
			posicionAnterior = position
			posicionSiguiente = derecha.proximaPosicion(position)
		if(obstaculosGenerales.posiciones().contains(posicionSiguiente)){
				direccion = "izquierda"
				self.caminarAIzquierda()
				}else{
				position = posicionSiguiente
			}
		}
	}
	
	method escupir(){
		if(direccion == "derecha"){
			const baba = new Baba(direccion = direccion, position = position, image = "BabaDer.png")
		}
		else {
			const baba = new Baba(direccion = direccion, position = position, image = "BabaIzq.png")
		}
		game.addVisual(baba)
		babaEnJuego.add(baba)
	}
}

class Baba{
	var property direccion = null
	var property position = null
	var property image = null
	var property posicionAnterior = game.at(0,0)
	var property posicionSiguiente = game.at(0,0)
	
	method avanzar(){
		if(direccion == "derecha"){
			posicionAnterior = position
			posicionSiguiente = derecha.proximaPosicion(position)
			position = posicionSiguiente
		}
		else {
			posicionAnterior = position
			posicionSiguiente = izquierda.proximaPosicion(position)
			position = posicionSiguiente
		}
	}
}*/
