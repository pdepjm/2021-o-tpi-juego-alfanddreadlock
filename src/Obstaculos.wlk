import wollok.game.*
import NPCs.*

class Panel{
	const property image = "panel.png"
	var property position = game.at(0,5)
	method posicion()=position
}

object panel{
	const property image = "panel.png"
	const property position = game.at(0,15)
	const property posiciones = [game.at(0,13),game.at(1,13),game.at(2,13),game.at(3,13),game.at(4,13),game.at(5,13),game.at(6,13),game.at(7,13),game.at(8,13),game.at(9,13),game.at(10,13),game.at(11,13),game.at(12,13),game.at(13,13),game.at(14,13),game.at(0,14),game.at(1,14),game.at(2,14),game.at(3,14),game.at(4,14),game.at(5,14),game.at(6,14),game.at(7,14),game.at(8,14),game.at(9,14),game.at(10,14),game.at(11,14),game.at(12,14),game.at(13,14),game.at(14,14)]
	const paneles = []
	method posicion()=position
	method crear(){
		posiciones.forEach({posicion=>paneles.add(new Panel(position=posicion))})
		generador.sumarVisual(paneles)
	}
}
class PlantaD{
	const property image = "plantaD.png"
	var property position = game.at(14,0)
	method posicion()=position
}
	
object plantasD{
	const property posiciones = [game.at(14,0),game.at(14,1),game.at(14,2),game.at(14,3),game.at(14,4),game.at(14,5),game.at(14,6),game.at(14,7),game.at(14,8),game.at(14,9),game.at(14,10),game.at(14,11),game.at(14,12)]
	const plantas = []
	method crear(){
		posiciones.forEach{posicion=>plantas.add(new PlantaD(position = posicion))}
		generador.sumarVisual(plantas)
	}
}

class PlantaI{
	const property image = "plantaI.png"
	var property position = game.at(0,0)
	method posicion()=position
}
	
object plantasI{
	const property posiciones = [game.at(0,0),game.at(0,1),game.at(0,2),game.at(0,3),game.at(0,4),game.at(0,5),game.at(0,6),game.at(0,7),game.at(0,8),game.at(0,9),game.at(0,10),game.at(0,11),game.at(0,12)]
	const plantas = []
	method crear(){
		posiciones.forEach{posicion=>plantas.add(new PlantaI(position = posicion))}
		generador.sumarVisual(plantas)
	}
}

class PlantaA{
	const property image = "plantaArriba.png"
	var property position = game.at(0,12)
	method posicion()=position
}
	
object plantasA{
	const property posiciones = [game.at(0,12),game.at(1,12),game.at(2,12),game.at(3,12),game.at(4,12),game.at(5,12),game.at(6,12),game.at(7,12),game.at(8,12),game.at(9,12),game.at(10,12),game.at(12,12),game.at(13,12),game.at(14,12)]
	const plantas = []
	method crear(){
		posiciones.forEach{posicion=>plantas.add(new PlantaA(position = posicion))}
		generador.sumarVisual(plantas)
	}
}

class Roca{
	const property image = "roca2.png"
	var property position = game.at(1,1)
	method posicion()=position
	}
	
object rocas{
	const property posiciones = [game.at(1,7),game.at(2,1),game.at(2,3),game.at(2,5),game.at(2,7),game.at(2,9),game.at(2,10),game.at(4,1),game.at(4,3),game.at(4,5),game.at(4,7),game.at(4,9),game.at(4,10),game.at(5,7),game.at(6,0),game.at(6,1),game.at(6,2),game.at(6,3),game.at(6,5),game.at(6,6),game.at(6,7),game.at(6,9),game.at(6,10),game.at(7,7),game.at(8,1),game.at(8,3),game.at(8,5),game.at(8,7),game.at(8,9),game.at(8,10),game.at(10,1),game.at(10,3),game.at(10,5),game.at(10,7),game.at(10,9),game.at(10,10),game.at(11,7),game.at(12,1),game.at(12,3),game.at(12,5),game.at(12,7),game.at(12,8),game.at(12,10)]
	const rocas = []
	method crear(){
		posiciones.forEach{posicion=>rocas.add(new Roca(position = posicion))}
		generador.sumarVisual(rocas)
	}
}


class Rompible{
	const property image = "Tronco.png"
	var property position = game.at(3,0)
}

object troncos{
	const property posiciones = [game.at(3,0),game.at(0,2)]
	const troncos = []
	method crear(){
		posiciones.forEach{posicion=>troncos.add(new Rompible(position = posicion))}
		generador.sumarVisual(troncos)
	}
}

object generador{
	method sumarVisual(obstaculos){
		obstaculos.forEach{obstaculo=>game.addVisual(obstaculo)}
	}
	//method generarObstaculo(posiciones,tipo){
		//if(tipo=="rompible"){
			//posiciones.forEach{posicion=>troncos.add(new Rompible(position = posicion))}
		//}
		//else{
			//posiciones.forEach{posicion=>troncos.add(new Roca(position = posicion))}
		//}
	//}
}

object obstaculosGenerales{
	const property posiciones = rocas.posiciones()+troncos.posiciones()+plantasI.posiciones()+plantasD.posiciones()+plantasA.posiciones()
	const property obstaculos = [troncos,rocas,plantasI,plantasD,plantasA,panel]
}



class Bomba { 
	var property image = "bomba.png"
	var property position = game.at(2,0)
	var property exploto = false
	const explosion = new Explosion()
	method explotar(){
		obstaculosGenerales.posiciones().add(position)
		game.schedule(2000,{self.explotando()})
	}
	method explotando(){
		obstaculosGenerales.posiciones().remove(position)
		game.removeVisual(self)
		explosion.mostrar(position)
		exploto = true
	}
}