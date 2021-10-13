import wollok.game.*
import direcciones.*
import ConfigGen.*


object carpincho{
	var property image = "carpincho1.png"
	var property direccion = "izquierda"
	var property position = game.at(9,2)
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
			image = "carpinchoI.png"
			posicionAnterior = position
			posicionSiguiente = izquierda.proximaPosicion(position)
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
	var property position = game.at(9,2)
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
			image = "LlamaDer.png"
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