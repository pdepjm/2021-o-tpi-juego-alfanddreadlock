import wollok.game.*
import direcciones.*
object config{
	method configuracionInicial(){
		game.addVisual(bomberman)
		self.configurarTeclas()
	}
	method configurarTeclas(){
		keyboard.left().onPressDo({ bomberman.moverPara(izquierda) })
		keyboard.right().onPressDo({ bomberman.moverPara(derecha) })
		keyboard.up().onPressDo({ bomberman.moverPara(arriba) })
		keyboard.down().onPressDo({ bomberman.moverPara(abajo) })
	}
}


object bomberman{
	const property image = "bomberman.gif"
	var property position = game.at(15,0)
	method moverPara(direccion) {
		position = direccion.proximaPosicion(position) 
	}
}