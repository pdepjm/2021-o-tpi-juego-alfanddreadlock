import wollok.game.*
import direcciones.*
import ConfigGen.*
import Obstaculos.*
import soundProducer.*

object bomberman{
	// esto seria para intentar lograr movimiento cuando el bomberman se mueve: const property movDerecha = ["bombermanDer1.png","bombermanDer2.png","bombermanDer3.png","bombermanDer4.png","bombermanDer5.png","bomberman.png"]
	var property image = "bomberman.png"
	var property position = game.at(0,0)
	const property esPP = true
	var bombasDisponibles = 1
	const bombasPuestas = []
	var alcance = 1
	var vidas = 3
	method posicion()=position
	method reiniciarPosicion(){//Bomberman vuelve a la posición de inicio
		position=game.at(0,0)
	}
	method moverPara(direccion) {
		direccion.movemePara(self,position,1) //las direcciones son quienes se encargan de mover al personaje
	}
	
	method ponerBomba(){
		self.recuperarBombas()
		if(bombasDisponibles>0){
			bombasPuestas.add(new Bomba(position = position))
			bombasDisponibles -=1
			game.addVisual(bombasPuestas.last())
			bombasPuestas.last().explotar(alcance)
		}
		else{
			game.say(self, "Bombas Insuficientes")
		}
	}
	method recuperarBombas(){
		bombasPuestas.forEach{bomba=>if(bomba.exploto()){
				bombasPuestas.remove(bomba)
				bombasDisponibles+=1
		}}
	}
	method sumarBomba(){bombasDisponibles+=1}
	method expandirAlcance(){alcance+=1}

	method perder(){ 
		vidas-=1
		self.reiniciarPosicion()
		if(vidas<0){
			self.morir()
		
		}
	}
	method morir(){
		game.removeVisual(self)
	}
	method modificarImagen(imagen){
		image = imagen
	}
}



class Explosion{
	var property image = "Explosion0.png"
	var property position = null
	var indice = 1
	const explosionesVinculadas=[]
	method mostrar(alcance){
		explosionesVinculadas.add(self)
		(1..alcance).forEach{i=>direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,i)}} //se podria hacer un game.schedule para que se muestre como animacion??
		//alcance.times{i=>direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,i)}} //INTENTO 1 -> al parecer la "i" no va aumentando
		explosionesVinculadas.forEach{explosion => self.configurarExplosion(explosion)}
		game.schedule(1500,{self.finDeExplosion()})
	}
	method configurarExplosion(explosion){
		game.addVisual(explosion)
		game.sound("bombaSonidoCorto.mp3").play()
		game.onCollideDo(explosion,{elemento=>elemento.perder()})
	}
	/*method controlDeAlcance(){
		direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,indice)}
		indice+=1
	} INTENTO2 */ 
	method expandirse(direccion,cantidad){
		if(direccion.puedeSeguir(position,cantidad)){
			//if (direccion.esPosible(position,cantidad)){
				explosionesVinculadas.add(new ExtensionDeExplosion(position = direccion.proximaPosicion(position,cantidad))) 
			//}
			/*else{
				explosionesVinculadas.add(new ObjetoInvisible(direccion.proximaPosicion(position,cantidad)))
			}*/ //ESTO ME ESTA ROMPIENDO
		}
		else{indice+=1}
	}
	method finDeExplosion(){
		explosionesVinculadas.forEach{explosion => game.removeVisual(explosion)}
	}
	/*
	method expansionChFinal(){
			fuegoPuedeIrPara = direcciones.direccionesAldeanas(position)
			fuegoPuedeIrPara.forEach{posicion=>espaciosOcupados.add(new ObjetoInvisible(position=posicion))}
			espaciosOcupados.forEach{objetoInvisible => game.addVisual(objetoInvisible)}
	}*/
}
class ExtensionDeExplosion{
	const property esPP = false
	const property position = null
	method image() = "Explosion0.png"
}

class ObjetoInvisible{
	const property position = null
}



class Personaje{ //Ya que hay cosas repetidas tanto en los mounstruos como en el bomberman, todavia esta clase no se usa
	var property image = null
	var property position = null
	var vidas = 3
	method perder(){ 
		vidas-=1
		if(vidas<0){
			self.morir()
		}
	}
	method morir(){
		game.removeVisual(self)
	}
	method modificarImagen(imagen){
		image = imagen
	}
}

class MonstruoADistancia inherits Monstruo{
	const direccionesPosibles = #{izquierda, derecha}
	var property direccion = null
	
	/* override method movimiento(){				Este movimiento serviria para el carpincho con el con este modelo de direcciones
		if(direccion.esPosible(position,1)){
		 	direccion.movemePara(self, position, 1)
		 }
		else{ 
			self.cambiarDireccion()
			direccion.movemePara(self, position, 1)
		}
	}*/
	
	method movimiento(){
		direccion.movemePara(self,position,1)
	}
	
	method escupir(){
		const baba = new Baba(position = position, direccion = direccion, image = "BabaDer.png")
		game.addVisual(baba)
		babaEnJuego.add(baba)
	}
	
	method cambiarDireccion() {
		direccion = direccionesPosibles.find({i => i != direccion}) // Hay que hacer un anyOne que no devuelva el mismo valor (se puede hacer tambien agregando y sacando, es medio feo)
	}
}

class Baba{
	var property image = null
	var property position = null
	const direccion = null
	
	method avanzar(){
		direccion.movemePara(self, position, 1)
	}
}
const llama = new MonstruoADistancia (position = game.at(6,12), direccion = izquierda, imageI = "LlamaIzq.png", imageD = "LlamaDer.png", image = "LlamaIzq.png")

class Monstruo{
	var property imageI = null
	var property imageD = null
	var property image = null
	var property position = null
	const direcciones = #{izquierda, derecha, arriba, abajo}
	const movimiento = null
	const mata = null
	const sonidoMatar=null	
	method sonidoMatar()=sonidoMatar
	
//Monstruo hace perder a bomberman	
	method matar(){
		if(self.position()==bomberman.posicion()){
			bomberman.perder()
			game.sound(sonidoMatar).play()
		}
	}
//Monstruo pierde al ser explotado
	method perder(){
		muerte.a(self)
		game.removeTickEvent(movimiento)
		game.removeTickEvent(mata)
	}
}

//Mata monstruos, no lo apliqué a bomberman.
object muerte{
	method a(personaje){
		game.removeVisual(personaje)
	}
}

const carpincho1 = new Monstruo (imageI = "carpinchoI.png",imageD = "carpinchoD.png",image="carpinchoI.png", position = game.at(12,12),movimiento= "carpincho1Moving",mata="carpincho1Asesino",sonidoMatar="risaPatan.mp3")
const carpincho2 = new Monstruo (imageI = "carpinchoI.png",imageD = "carpinchoD.png",image="carpinchoI.png", position = game.at(7,4),movimiento="carpincho2Moving",mata="carpincho2Asesino",sonidoMatar="risaPatan.mp3")
const direccionamientoCarpincho1 = new Direccionamiento(direction=left,nextPosition=left.next(carpincho1))
const direccionamientoCarpincho2 = new Direccionamiento (direction=left,nextPosition=left.next(carpincho2))

