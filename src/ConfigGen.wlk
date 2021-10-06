import wollok.game.*
import direcciones.*
import soundProducer.*

object config{
	method configuracionInicial(){
		
		game.addVisual(bomberman)
		self.configurarTeclas()
		self.configurarColisiones()
		rocas.rocasGenerator()
		
	}
	method configurarTeclas(){
		keyboard.left().onPressDo({ bomberman.moverPara(izquierda) })
		keyboard.right().onPressDo({ bomberman.moverPara(derecha) })
		keyboard.up().onPressDo({ bomberman.moverPara(arriba) })
		keyboard.down().onPressDo({ bomberman.moverPara(abajo) })
		keyboard.s().onPressDo({backgroundMusic.mandaleCumbia()})
	}
	method configurarColisiones(){
	}
}


object bomberman{
	const property image = "bomberman.gif"
	var property position = game.at(0,0)
	var posicionAnterior = game.at(0,0)
	var posicionSiguiente = game.at(0,0)
	method moverPara(direccion) {
			posicionAnterior=position
			posicionSiguiente = direccion.proximaPosicion(position)
		if(rocas.posiciones().contains(posicionSiguiente)){
			self.quedarseQuieto()
		}
		else if(posicionSiguiente.x()>13 or posicionSiguiente.x()<0 or posicionSiguiente.y()<0 or posicionSiguiente.y()>13){
			self.quedarseQuieto()
		}
		else{
			position = posicionSiguiente 
		}
	}
	method quedarseQuieto(){
		position = posicionAnterior
	}
}

object backgroundMusic{
	const sonido = game.sound("adventure.wav")
	
	method configurarSonido(){
			sonido.volume(1)
		}
	method mandaleCumbia(){
		sonido.play()
	}
}
object gestorDeNiveles{
	var nivel = 0
	
}

class Roca{
	const property image = "roca2.png"
	var property position = game.at(1,1)
	method posicion()=position
	}
	
	
object rocas{
	const property posiciones = [game.at(0,1),game.at(0,6),game.at(0,7),game.at(1,1),game.at(1,3),game.at(1,5),game.at(1,7),game.at(1,8),game.at(1,10),game.at(1,12),game.at(2,6),game.at(2,7),game.at(3,1),game.at(3,3),game.at(3,5),game.at(3,10),game.at(3,12),game.at(4,6),game.at(4,7),game.at(5,1),game.at(5,3),game.at(5,5),game.at(5,7),game.at(5,8),game.at(5,10),game.at(5,12),game.at(6,6),game.at(6,7),game.at(7,1),game.at(7,3),game.at(7,5),game.at(7,7),game.at(7,8),game.at(7,9),game.at(7,10), game.at(7,12),game.at(7,13),game.at(9,1),game.at(9,3),game.at(9,5),game.at(9,7),game.at(9,9),game.at(9,10),game.at(9,11),game.at(9,13),game.at(10,1),game.at(10,5),game.at(11,1),game.at(11,3),game.at(11,5),game.at(11,7),game.at(11,9),game.at(11,11),game.at(11,13),game.at(12,13),game.at(13,1),game.at(13,2),game.at(13,3),game.at(13,4),game.at(13,5),game.at(13,6),game.at(13,7),game.at(13,8),game.at(13,9),game.at(13,10),game.at(13,11),game.at(13,12),game.at(13,13)]
	const rocas = []
	method rocasGenerator(){
		posiciones.forEach{posicion=>rocas.add(new Roca(position = posicion))}
		rocas.forEach{roca=>game.addVisual(roca)}
	}
}