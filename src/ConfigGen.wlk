import wollok.game.*
import direcciones.*
import soundProducer.*
import NPCs.*
import Obstaculos.*
const babaEnJuego = []

object config{
	method configuracionInicial(){
		
		game.addVisual(bomberman)
//		game.addVisual(carpincho)
//		game.onTick(400,"carpinchoMoving",{=> carpincho.caminar()})
		game.addVisual(llama)
		game.onTick(400,"llamaMoving",{=> llama.caminar()})
		game.onTick(4000,"llamaEscupir",{=> llama.escupir()})
		game.onTick(200,"babaMover",{=> babaEnJuego.forEach{unaBaba => unaBaba.avanzar()}})
		self.configurarTeclas()
		self.configurarColisiones()
		rocas.rocasGenerator()
		plantasD.plantasGenerator()
		plantasI.plantasGenerator()
		plantasA.plantasGenerator()
		troncos.troncosGenerator()
		panel.generator()
		
		
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
		game.onTick(100,"gifGenerico",{objeto.modificarImagen(imagenes.get(indice))})
		indice+=1
	}
}

/*
object gestorDeNiveles{
	var nivel = 0
	
}*/
