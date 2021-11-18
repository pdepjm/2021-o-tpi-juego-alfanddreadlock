import wollok.game.*
import NPCs.*
import direcciones.*

const troncos = new GeneradorDeObstaculosRompibles (imagen = "tronco.png", posiciones = [game.at(1,7),game.at(2,4),game.at(2,6),game.at(2,12),game.at(5,0),game.at(5,2),game.at(5,4),game.at(5,6),game.at(5,8),game.at(5,11),game.at(7,0),game.at(7,2),game.at(7,6),game.at(7,8),game.at(7,11),game.at(9,2),game.at(9,4),game.at(9,6),game.at(9,8),game.at(9,11),game.at(11,0),game.at(11,2),game.at(11,4),game.at(11,6),game.at(11,8),game.at(11,11)])
const plantasI = new GeneradorDeObstaculosNoRompibles (imagen = "plantaI.png",posiciones = [game.at(0,0),game.at(0,1),game.at(0,2),game.at(0,3),game.at(0,4),game.at(0,5),game.at(0,6),game.at(0,7),game.at(0,8),game.at(0,9),game.at(0,10),game.at(0,11),game.at(0,12),game.at(0,13)])
const plantasD = new GeneradorDeObstaculosNoRompibles (imagen = "plantaD.png",posiciones = [game.at(13,0),game.at(13,1),game.at(13,2),game.at(13,3),game.at(13,4),game.at(13,5),game.at(13,6),game.at(13,7),game.at(13,8),game.at(13,9),game.at(13,10),game.at(13,11),game.at(13,12),game.at(13,13)])
const plantasA = new GeneradorDeObstaculosNoRompibles (imagen = "plantaArriba.png",posiciones = [game.at(0,13),game.at(1,13),game.at(2,13),game.at(3,13),game.at(4,13),game.at(5,13),game.at(6,13),game.at(7,13),game.at(8,13),game.at(9,13),game.at(10,13),game.at(11,13),game.at(12,13),game.at(13,13),game.at(13,13)])
const rocas = new GeneradorDeObstaculosNoRompibles (imagen = "roca2.png",posiciones = [game.at(2,1),game.at(2,3),game.at(2,5),game.at(2,7),game.at(2,9),game.at(2,10),game.at(4,1),game.at(4,3),game.at(4,5),game.at(4,7),game.at(4,9),game.at(4,10),game.at(5,7),game.at(6,0),game.at(6,1),game.at(6,2),game.at(6,3),game.at(6,5),game.at(6,6),game.at(6,7),game.at(6,9),game.at(6,10),game.at(7,7),game.at(8,1),game.at(8,3),game.at(8,5),game.at(8,7),game.at(8,9),game.at(8,10),game.at(10,1),game.at(10,3),game.at(10,5),game.at(10,7),game.at(10,9),game.at(10,10),game.at(11,7),game.at(12,1),game.at(12,3),game.at(12,5),game.at(12,7),game.at(12,8),game.at(12,10)])

class GeneradorDeObstaculos{		//Una clase con una lista de posiciones.
	var property posiciones = []
	const imagen
	method crear(){
		posiciones.forEach{posicion=>self.tipoDeObstaculo(posicion).aparecer()}
	}
	method tipoDeObstaculo(posicion)	
}

class GeneradorDeObstaculosNoRompibles inherits GeneradorDeObstaculos{
	override method tipoDeObstaculo(posicion) =	new Obstaculo (image = imagen, position=posicion)
}

class GeneradorDeObstaculosRompibles inherits GeneradorDeObstaculos{
	override method tipoDeObstaculo(posicion) =	new ObstaculoRompible (image = imagen, position=posicion)
}

class Obstaculo{				//Una clase de lo que sería un obstaculo individual, una única posición y una imágen.
	var property image 
	var property position
	
	method aparecer(){
		game.addVisual(self)
		obstaculosGenerales.agregarObstaculo(self)
	}
	
	method meExplotoUnaBombaEncima(){}
}

class ObstaculoRompible inherits Obstaculo{
	const poderPosible = [new Fuego(position = position),new BombaExtra(position = position),new NoPoder(),new NoPoder(),new NoPoder(),new NoPoder()].anyOne()
	override method meExplotoUnaBombaEncima(){
		poderPosible.aparecer()
		obstaculosGenerales.sacarObstaculo(self)
		game.removeVisual(self)
	}
}

class Bomba { 
	var property image = "bomba.png"
	var property position = game.at(2,0)
	var property exploto = false
	const explosion = new ExplosionCentral(position = position)
	method explotar(rango){
		obstaculosGenerales.agregarObstaculo(self)
		game.schedule(1000,{self.explotando(rango)})
	}
	method explotando(rango){
		obstaculosGenerales.sacarObstaculo(self)
		game.removeVisual(self)
		explosion.mostrar(rango)
		exploto = true
	}
	
	method meLlevoPuesto(alguien){}
	method meExplotoUnaBombaEncima(){}
}

object obstaculosGenerales {
	const property obstaculos = []
	const limites = (0..13).map{i=>game.at(-1,i)} + (0..13).map{i=>game.at(14,i)} + (0..13).map{i=>game.at(i,-1)} + (0..13).map{i=>game.at(i,14)}
	method posiciones() = self.obstaculos().map{obstaculo=>obstaculo.position()} + limites
	method sacarObstaculo(obstaculo){obstaculos.remove(obstaculo)}
	method agregarObstaculo(obstaculo){obstaculos.add(obstaculo)}
}

class Agarrable{
	var property image
	var property position
	
	method aparecer(){
		game.addVisual(self)
	}
	method meLlevoPuesto(alguien){	
		game.removeVisual(self)
	}
	
	method meExplotoUnaBombaEncima(){game.removeVisual(self)}
}

class Fuego inherits Agarrable(image="fuego.png"){
	override method meLlevoPuesto(alguien){	
		alguien.expandirAlcance()
		super(alguien)
	}
}

class BombaExtra inherits Agarrable(image="bombaAgarrable.png"){
	override method meLlevoPuesto(alguien){	
		alguien.sumarBomba()
		super(alguien)
	}
}

class NoPoder{method aparecer(){}}