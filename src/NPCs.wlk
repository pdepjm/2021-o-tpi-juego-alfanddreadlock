import wollok.game.*
import direcciones.*
import ConfigGen.*
import Obstaculos.*


object bomberman{
	var property image = "bomberman.png"
	var property position = game.at(0,0)
	const property movDerecha = ["bombermanDer1.png","bombermanDer2.png","bombermanDer3.png","bombermanDer4.png","bombermanDer5.png","bomberman.png"]
	
	var posicionAnterior = game.at(0,0)
	var posicionSiguiente = game.at(0,0)
	var bombasDisponibles = 1
	const bombasPuestas = []
	var vidas = 3
	method moverPara(direccion) {
		// si me puedo mover, me muevo.
		
			posicionAnterior=position
			posicionSiguiente = direccion.proximaPosicion(position)
		if(obstaculosGenerales.posiciones().contains(posicionSiguiente)){
			self.quedarseQuieto()
		}
		else if(posicionSiguiente.x()>13 or posicionSiguiente.x()<0 or posicionSiguiente.y()<0 or posicionSiguiente.y()>13){
			self.quedarseQuieto()
		}
		else{
			//direccion.movimiento(self)
			position = posicionSiguiente 
		}
	}
	method quedarseQuieto(){
		position = posicionAnterior
	}
	method ponerBomba(){
		self.recuperarBombas()
		if(bombasDisponibles>0){
			bombasPuestas.add(new Bombas(position = position))
			bombasDisponibles -=1
			game.addVisual(bombasPuestas.last())
			bombasPuestas.last().explotar()
		}
		else{
			game.error("Bombas Insuficientes")
		}
	}
	method recuperarBombas(){
		bombasPuestas.forEach{bomba=>if(bomba.exploto()){
				bombasPuestas.remove(bomba)
				bombasDisponibles+=1
		}}
	}
	method morir(){ //perder vida
		vidas-=1
		if(vidas<0){
			self.perder()
		}
	}
	method perder(){
		game.removeVisual(self)
	}
	method modificarImagen(imagen){
		image = imagen
	}
}

class Explosion{
	var property image = "expCh1.png"
	var property position = game.at(3,0)
	method mostrar(posicion){
		position = posicion
		game.addVisual(self)
		game.onTick(750,"explotando",{image="expCh2.png"})
		game.onTick(1000,"explotando",{image="expCh3.png"})
		game.onTick(1500,"termino",{game.removeVisual(self)})
	}
	
}

object carpincho{
	var property image = "carpincho1.png"
	var property direccion = "izquierda"
	var property position = game.at(9,2)
	var property posicionAnterior = game.at(0,0)
	var property posicionSiguiente = game.at(0,0)

	method caminar(){
		// dirección <- objeto copado que sabe hacer cosas
		// direccion.moverA(self)
		
		if (direccion=="izquierda"){
			self.caminarAIzquierda()
			}else{
		self.caminarADerecha()
		}
	}
	method caminarAIzquierda(){
		if (direccion == "izquierda"){
			image = "carpinchoI.png"
			posicionAnterior = position
			posicionSiguiente = izquierda.proximaPosicion(position)
			
		// simplificar y delegar
		// esto está mal, porque en vez que delegarle polimórficamente a los obstáculos saber si son atravesables o no, deciden uds acá.
		if(rocas.posiciones().contains(posicionSiguiente)||plantasD.posiciones().contains(posicionSiguiente)||plantasI.posiciones().contains(posicionSiguiente)||plantasA.posiciones().contains(posicionSiguiente)){
			direccion = "derecha"
			self.caminarADerecha()
				}else{
				position = posicionSiguiente 
			}
		}
	}
	
	method caminarADerecha(){
		if (direccion == "derecha"){
			image = "carpinchoD.png"
			posicionAnterior = position
			posicionSiguiente = derecha.proximaPosicion(position)
		if(rocas.posiciones().contains(posicionSiguiente)||plantasD.posiciones().contains(posicionSiguiente)||plantasI.posiciones().contains(posicionSiguiente)||plantasA.posiciones().contains(posicionSiguiente)){
				direccion = "izquierda"
				self.caminarAIzquierda()
				}else{
				position = posicionSiguiente
			}
		}
	}
}
object llama{
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
}