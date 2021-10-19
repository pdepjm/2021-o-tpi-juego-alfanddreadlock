import wollok.game.*
import NPCs.*
import direcciones.*


const troncos = new EspecieDeObstaculo (posiciones = [game.at(1,4),game.at(1,8),game.at(3,2),game.at(3,4),game.at(3,6),game.at(3,8),game.at(5,0),game.at(5,2),game.at(5,4),game.at(5,6),game.at(5,8),game.at(5,11),game.at(7,0),game.at(7,2),game.at(7,4),game.at(7,6),game.at(7,8),game.at(7,11),game.at(9,2),game.at(9,4),game.at(9,6),game.at(9,8),game.at(9,11),game.at(11,0),game.at(11,2),game.at(11,4),game.at(11,6),game.at(11,8),game.at(11,11),game.at(13,0),game.at(13,2),game.at(13,4),game.at(13,6),game.at(13,8)])
const plantasI = new EspecieDeObstaculo (posiciones = [game.at(0,0),game.at(0,1),game.at(0,2),game.at(0,3),game.at(0,4),game.at(0,5),game.at(0,6),game.at(0,7),game.at(0,8),game.at(0,9),game.at(0,10),game.at(0,11),game.at(0,12)])
const plantasD = new EspecieDeObstaculo (posiciones = [game.at(14,0),game.at(14,1),game.at(14,2),game.at(14,3),game.at(14,4),game.at(14,5),game.at(14,6),game.at(14,7),game.at(14,8),game.at(14,9),game.at(14,10),game.at(14,11),game.at(14,12)])
const plantasA = new EspecieDeObstaculo (posiciones = [game.at(0,12),game.at(1,12),game.at(2,12),game.at(3,12),game.at(4,12),game.at(5,12),game.at(6,12),game.at(7,12),game.at(8,12),game.at(9,12),game.at(10,12),game.at(12,12),game.at(13,12),game.at(14,12)])
const rocas = new EspecieDeObstaculo (posiciones = [game.at(1,7),game.at(2,1),game.at(2,3),game.at(2,5),game.at(2,7),game.at(2,9),game.at(2,10),game.at(4,1),game.at(4,3),game.at(4,5),game.at(4,7),game.at(4,9),game.at(4,10),game.at(5,7),game.at(6,0),game.at(6,1),game.at(6,2),game.at(6,3),game.at(6,5),game.at(6,6),game.at(6,7),game.at(6,9),game.at(6,10),game.at(7,7),game.at(8,1),game.at(8,3),game.at(8,5),game.at(8,7),game.at(8,9),game.at(8,10),game.at(10,1),game.at(10,3),game.at(10,5),game.at(10,7),game.at(10,9),game.at(10,10),game.at(11,7),game.at(12,1),game.at(12,3),game.at(12,5),game.at(12,7),game.at(12,8),game.at(12,10)])

const plantaD = new UnObstaculo (image = "plantaD.png")
const plantaI = new UnObstaculo (image = "plantaI.png")
const plantaA = new UnObstaculo (image = "plantaArriba.png")
const roca = new UnObstaculo (image = "roca2.png")
const tronco = new UnObstaculo(image = "tronco.png")


class UnObstaculo{				//Una clase de lo que sería un obstaculo individual, una única posición y una imágen.
	var property image = null
	var property position = null
	method image() = image
	method posicion() = position
}

class EspecieDeObstaculo{		//Una clase con una lista de posiciones.
	var property posiciones = []
	var property obstaculos=[]
	method posiciones() = posiciones
	method crear(unObstaculo){
	posiciones.forEach{posicion=>obstaculos.add(new UnObstaculo (image = unObstaculo.image(), position=posicion))}
	generador.sumarVisual(obstaculos)
	}
}

object generador{
	method sumarVisual(especieDeObstaculo){
		especieDeObstaculo.forEach{obstaculo=>game.addVisual(obstaculo)}
	}
}


object obstaculosGenerales{
	const property obstaculos = [plantasI,plantasD,plantasA,rocas,troncos]
	const property posiciones = plantasI.posiciones()+plantasD.posiciones()+plantasA.posiciones()+rocas.posiciones()+troncos.posiciones()
	method posiciones()=posiciones
}

/*
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
*/