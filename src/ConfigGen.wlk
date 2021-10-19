import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*
const babaEnJuego = []

object config{
	method configuracionInicial(){
		plantasI.crear(plantaI)
		plantasD.crear(plantaD)
		plantasA.crear(plantaA)
		rocas.crear(roca)
		troncos.crear(tronco)
		game.addVisual(carpincho)
//		game.addVisual(bomberman)

//		game.addVisual(llama)
		game.onTick(250,"carpinchoMoving",{=> direccionCarpincho.moverAutomatico(carpincho)})
//		game.onTick(300,"llamaMoving",{=>direccionLlama.moverAutomatico(llama)})
//		game.onTick(400,"llamaMoving",{=> llama.caminar()})
//		game.onTick(4000,"llamaEscupir",{=> llama.escupir()})
//		game.onTick(200,"babaMover",{=> babaEnJuego.forEach{unaBaba = unaBaba.avanzar()}})
//		obstaculosGenerales.obstaculos().forEach{obstaculo=obstaculo.crear()}

//		self.configurarTeclas()
//		self.configurarColisiones()
//		 Saber qué clase instanciar
//		 Saber en qué posiciones instanciarlas.
//		 Sí van a necesitar tener varias listas de posiciones
//		 el forEach que escriban debería ser 1 solo.
	}
}
/*	
	method configurarTeclas(){
		keyboard.left().onPressDo({ bomberman.moverPara(derecha) })
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
		imagenes.size().times{i=self.recorrerFrames(objeto,imagenes)}
	}
	method recorrerFrames(objeto,imagenes){
		game.onTick(100,gifGenerico,{objeto.modificarImagen(imagenes.get(indice))})
		indice+=1
	}
}


object gestorDeNiveles{
	var nivel = 0
	
}
*/