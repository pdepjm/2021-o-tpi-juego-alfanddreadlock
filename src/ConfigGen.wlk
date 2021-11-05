import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*

const personajes = [bomberman /*,carpincho*/,llama]
object config{
	const obstaculosPosibles = [troncos,rocas,plantasD,plantasA,plantasI]
	
	method configuracionInicial(){
		obstaculosPosibles.forEach{obstaculo=>obstaculo.crear()}//Se repite este forEach tanto aca como en personajes
		self.configurarPersonajes()
		self.configurarTeclas()
		self.configurarColisiones()
	}

	
	method configurarTeclas(){
		keyboard.left().onPressDo({ bomberman.moverPara(izquierda) })
		keyboard.right().onPressDo({ bomberman.moverPara(derecha) })
		keyboard.up().onPressDo({ bomberman.moverPara(arriba) })
		keyboard.down().onPressDo({ bomberman.moverPara(abajo) })
		keyboard.s().onPressDo({backgroundMusic.mandaleCumbia()})
		keyboard.space().onPressDo({bomberman.ponerBomba()})
		keyboard.r().onPressDo({juego.reset()})
	}
	method configurarColisiones(){
		game.onCollideDo(bomberman,{elemento=>elemento.meLlevoPuesto(bomberman)})
	}
	method configurarPersonajes(){
		personajes.forEach{personaje=>personaje.crear()
		
		}
	}
}

object juego{
	method reset(){
		game.clear()
		config.configuracionInicial()
		
	}
}




