import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*
const babaEnJuego = []

object config{
	method configuracionInicial(){
		const obstaculosPosibles = [troncos,rocas,plantasD,plantasA,plantasI]
		game.addVisual(carpincho1)
		game.addVisual(carpincho2)
		game.addVisual(bomberman)

		game.onTick(200,"carpincho1Moving",{=> direccionamientoCarpincho1.automatic(carpincho1)})
		game.onTick(1,"carpincho1Asesino",{=>carpincho1.matar()})
		game.onTick(200,"carpincho2Moving",{=> direccionamientoCarpincho2.automatic(carpincho2)})
		game.onTick(1,"carpincho2Asesino",{=>carpincho2.matar()})
		
		//game.addVisual(llama)
		//game.onTick(300,"llamaMoving",{=>direccionLlama.moverAutomatico(llama)})
//		game.onTick(400,"llamaMoving",{=> llama.caminar()})
		//game.onTick(4000,"llamaEscupir",{=> llama.escupir()})
//		game.onTick(200,"babaMover",{=> babaEnJuego.forEach{unaBaba => unaBaba.avanzar()}})
		obstaculosPosibles.forEach{obstaculo=>obstaculo.crear()}

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
	}
}

object gif{
	var indice = 0
	method hacerGif(objeto,imagenes){
		imagenes.size().times{i=>self.recorrerFrames(objeto,imagenes)}
	}
	method recorrerFrames(objeto,imagenes){
		game.schedule(100,{objeto.modificarImagen(imagenes.get(indice))})
		indice+=1
	}
}


