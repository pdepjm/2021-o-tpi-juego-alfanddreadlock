import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*
const babaEnJuego = []

object config{
	method configuracionInicial(){
		const obstaculosPosibles = [troncos,rocas,plantasD,plantasA,plantasI]
		//game.addVisual(carpincho)
		game.addVisual(bomberman)
		const llama = new Monstruo(image = "LlamaDer.png", position = game.at(2,5),nombre="llama")
		game.addVisual(llama)
		game.onTick(50,"llamaMoving", {=>llama.caminar()})
		//game.addVisual(llama)
		//game.onTick(250,"carpinchoMoving",{=> direccionCarpincho.moverAutomatico(carpincho)})
//		game.onTick(400,"llamaMoving",{=> llama.caminar()})
		//game.onTick(4000,"llamaEscupir",{=> llama.escupir()})
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


