import wollok.game.*
import NPCs.*
import direcciones.*

const troncos = new EspecieDeObstaculo (imagen = "tronco.png", sonRompibles=true, posiciones = [game.at(1,8),game.at(3,2),game.at(3,4),game.at(3,6),game.at(3,8),game.at(5,0),game.at(5,2),game.at(5,4),game.at(5,6),game.at(5,8),game.at(5,11),game.at(7,0),game.at(7,2),game.at(7,6),game.at(7,8),game.at(7,11),game.at(9,2),game.at(9,4),game.at(9,6),game.at(9,8),game.at(9,11),game.at(11,0),game.at(11,2),game.at(11,4),game.at(11,6),game.at(11,8),game.at(11,11)])
const plantasI = new EspecieDeObstaculo (imagen = "plantaI.png",posiciones = [game.at(0,0),game.at(0,1),game.at(0,2),game.at(0,3),game.at(0,4),game.at(0,5),game.at(0,6),game.at(0,7),game.at(0,8),game.at(0,9),game.at(0,10),game.at(0,11),game.at(0,12),game.at(0,13)])
const plantasD = new EspecieDeObstaculo (imagen = "plantaD.png",posiciones = [game.at(13,0),game.at(13,1),game.at(13,2),game.at(13,3),game.at(13,4),game.at(13,5),game.at(13,6),game.at(13,7),game.at(13,8),game.at(13,9),game.at(13,10),game.at(13,11),game.at(13,12),game.at(13,13)])
const plantasA = new EspecieDeObstaculo (imagen = "plantaArriba.png",posiciones = [game.at(0,13),game.at(1,13),game.at(2,13),game.at(3,13),game.at(4,13),game.at(5,13),game.at(6,13),game.at(7,13),game.at(8,13),game.at(9,13),game.at(10,13),game.at(11,13),game.at(12,13),game.at(13,13),game.at(13,13)])
const rocas = new EspecieDeObstaculo (imagen = "roca2.png",posiciones = [game.at(1,7),game.at(2,1),game.at(2,3),game.at(2,5),game.at(2,7),game.at(2,9),game.at(2,10),game.at(4,1),game.at(4,3),game.at(4,5),game.at(4,7),game.at(4,9),game.at(4,10),game.at(5,7),game.at(6,0),game.at(6,1),game.at(6,2),game.at(6,3),game.at(6,5),game.at(6,6),game.at(6,7),game.at(6,9),game.at(6,10),game.at(7,7),game.at(8,1),game.at(8,3),game.at(8,5),game.at(8,7),game.at(8,9),game.at(8,10),game.at(10,1),game.at(10,3),game.at(10,5),game.at(10,7),game.at(10,9),game.at(10,10),game.at(11,7),game.at(12,1),game.at(12,3),game.at(12,5),game.at(12,7),game.at(12,8),game.at(12,10)])
const poderes = ["fuego.png","bombaAgarrable.png"]


class UnObstaculo{				//Una clase de lo que sería un obstaculo individual, una única posición y una imágen.
	var property image = null
	var property position = null
	var poder = null
	const esRompible = false
	const posibilidadDePoder = [true,false,false]
	method perder(){
		if(esRompible){
			if(posibilidadDePoder.anyOne()){
				poder = new Agarrable(image = poderes.anyOne(),position = position)
				game.addVisual(poder)
				//Esto desde el vamos esta mal, pero no se como podria asegurarme de que el poder solo conozca al bomberman
				game.onCollideDo(poder,{algoDinamico => if(algoDinamico.esPP()){poder.meAgarro(algoDinamico)}})
				
			}
			obstaculosGenerales.obstaculos().remove(self)
			game.removeVisual(self)
		}
	}
}

class EspecieDeObstaculo{		//Una clase con una lista de posiciones.
	var property posiciones = []
	const imagen = null
	const property sonRompibles = false
	const obstaculosCreados = []
	
	method crear(){ //Borre la parte de la lista obstaculos y el generador, directamente se añade la imagen aca
		posiciones.forEach{posicion=>obstaculosCreados.add(new UnObstaculo (image = imagen, position=posicion,esRompible = sonRompibles))}
		obstaculosCreados.forEach{obstaculo => self.sumar(obstaculo)}
	}
	
	method sumar(obstaculo){
		game.addVisual(obstaculo)
		obstaculosGenerales.obstaculos().add(obstaculo)
	}
	
}

object obstaculosGenerales{
	const property obstaculos = []
	method posiciones() = self.obstaculos().map{obstaculo=>obstaculo.position()}
}

/* ******************************************************LO QUE BORRO GER*********************************************************

 class Panel{
	const property image = "panel.png"
	var property position = game.at(0,5)
	method posicion()=position
}

object panel{
	const property image = "panel.png"
	const property position = game.at(0,15)
	const property posiciones = [game.at(0,13),game.at(1,13),game.at(2,13)]
	const paneles = []
	method posicion()=position
	method crear(){
		posiciones.forEach({posicion=>paneles.add(new Panel(position=posicion))})
		generador.sumarVisual(paneles)
	}
}


***************************************FIN DE LO QUE BORRO GER ***********************************************************
*/
class Agarrable{
	var property image = null
	var property position = null
	method meAgarro(alguien){
		self.efecto(alguien)
		game.removeVisual(self)
	}
	method efecto(alguien){
		if(image=="fuego.png"){
			alguien.expandirAlcance()
		}
		else{
			alguien.sumarBomba()
		}
	}
	method perder(){game.removeVisual(self)}
}
class Fuego inherits Agarrable{
	override method efecto(alguien){
		
	}
}

class Bomba { 
	var property image = "bomba.png"
	var property position = game.at(2,0)
	var property exploto = false
	const explosion = new Explosion(position = position)
	method explotar(rango){
		obstaculosGenerales.posiciones().add(position)
		game.schedule(1000,{self.explotando(rango)})
	}
	method explotando(rango){
		obstaculosGenerales.posiciones().remove(position)
		game.removeVisual(self)
		explosion.mostrar(rango)
		exploto = true
	}
}
