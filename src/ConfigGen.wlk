import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*
const babaEnJuego = []

object config{
	const obstaculosPosibles = [troncos,rocas,plantasD,plantasA,plantasI]
	const personajes = [bomberman,carpincho,llama/* ,carpincho1,carpincho2*/]
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
	}
	method configurarColisiones(){
		game.onCollideDo(bomberman,{elemento=>elemento.efecto(bomberman)})
	}
	method configurarPersonajes(){
		personajes.forEach{personaje=>personaje.crear()}
		
		//game.onTick(200,"carpincho1Moving",{=> direccionamientoCarpincho1.automatic(carpincho1)})
		//game.onTick(1,"carpincho1Asesino",{=>carpincho1.matar()})
		//game.onTick(200,"carpincho2Moving",{=> direccionamientoCarpincho2.automatic(carpincho2)})
		//game.onTick(1,"carpincho2Asesino",{=>carpincho2.matar()}) 
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


