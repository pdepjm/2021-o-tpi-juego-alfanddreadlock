import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*

	const babasEnJuego = []
object config{
	const obstaculosPosibles = [troncos,rocas,plantasD,plantasA,plantasI]
	const personajes = [bomberman/*,llama carpincho,carpincho1,carpincho2*/]
	method configuracionInicial(){
		obstaculosPosibles.forEach{obstaculo=>obstaculo.crear()}//Se repite este forEach tanto aca como en personajes
		self.configurarPersonajes()
		self.configurarTeclas()
		self.configurarColisiones()
//		 Saber qué clase instanciar
//		 Saber en qué posiciones instanciarlas.
//		 Sí van a necesitar tener varias listas de posiciones

	}

	
	method configurarTeclas(){
		keyboard.left().onPressDo({ bomberman.moverPara(izquierda) })
		keyboard.right().onPressDo({ bomberman.moverPara(derecha) })
		keyboard.up().onPressDo({ bomberman.moverPara(arriba) })
		keyboard.down().onPressDo({ bomberman.moverPara(abajo) })
		keyboard.s().onPressDo({backgroundMusic.mandaleCumbia()})
		keyboard.space().onPressDo({bomberman.ponerBomba()})
		keyboard.r().onPressDo({reset.juego()})
	}
	method configurarColisiones(){
		game.onCollideDo(bomberman,{elemento=>elemento.efecto(bomberman)})
	}
	method configurarPersonajes(){
		personajes.forEach{personaje=>personaje.crear()
		game.onTick(500,"moverBabas",{babasEnJuego.forEach{baba=>baba.desplazarse()}})
		}
	}
}

object reset{
	method obstaculos(){
		obstaculosGenerales.posiciones().forEach{obstaculo=>obstaculo.clear()}
	}

	method juego(){
		self.obstaculos()
		bomberman.reiniciar()
		config.configuracionInicial()
		game.start()
	}
}

/*
object gif{
	var indice = 0
	method hacerGif(objeto,imagenes){
		imagenes.size().times{i=>self.recorrerFrames(objeto,imagenes)}
	}
	method recorrerFrames(objeto,imagenes){
		game.schedule(100,{objeto.modificarImagen(imagenes.get(indice))})
		indice+=1
	}
}*/


