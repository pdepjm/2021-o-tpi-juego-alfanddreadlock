import wollok.game.*
import direcciones.*
import ConfigGen.*
import Obstaculos.*
import soundProducer.*

class Personaje{ 
	var property image
	var property position = positionI
	const positionI 
	const nombre
	var vidas = 3
	method vidas() = vidas
	method crear(){
		vidas=3
		position=positionI
		game.addVisual(self)
		
	}
	method perder(){ 
		vidas-=1
		if(vidas<0){
			self.morir()
		}
	}
	method meExplotoUnaBombaEncima(){self.perder()}
	method morir(){
		game.removeVisual(self)
	}
	
	method direccionarVisual(direccion){
		image = nombre + direccion.nombre() + ".png"
	}
}

object bomberman inherits Personaje(image = "BombermanDerecha.png", positionI = game.at(1,0),nombre="Bomberman"){
	
	var bombasDisponibles = 1
	const bombasPuestas = []
	var alcance = 1
	
	override method crear(){
		bombasDisponibles=1
		alcance=1
		super()
		contadorVidas.aparecer()
	}
	method alcance() = alcance
	method bombasDisponibles() = bombasDisponibles 
	method moverPara(direccion) {
		direccion.movemePara(self,self.position(),1) //las direcciones son quienes se encargan de mover al personaje
	}
	override method perder(){
		super()
		contadorVidas.modificarImagen(vidas)
	}
	override method morir(){
		super()
		juego.reset()
	}
	method ponerBomba(){
		self.recuperarBombas()
		if(bombasDisponibles>0){
			bombasPuestas.add(new Bomba(position = self.position()))
			bombasDisponibles -=1
			game.addVisual(bombasPuestas.last())
			bombasPuestas.last().explotar(alcance)
		}
		else{
			game.say(self, "Bombas Insuficientes")
		}
		game.removeVisual(self)
		game.addVisual(self)
	}
	method recuperarBombas(){
		bombasPuestas.forEach{bomba=>if(bomba.exploto()){
				bombasPuestas.remove(bomba)
				bombasDisponibles+=1
		}}
	}
	method sumarBomba(){bombasDisponibles+=1}
	method expandirAlcance(){alcance+=1}
}

class Monstruo inherits Personaje{ 
	var property velocidad 
	var direccion = direccionesPermitidas.anyOne()
	
	override method crear(){
		super()
		game.onTick(1500,"atacar",{self.atacar()})
		self.establecerVelocidad()
	}
	
	method establecerVelocidad(){
		game.schedule(velocidad,{self.caminar()})
	}
	
	method caminar(){
		if(direccion.esPosible(position,1)){
			direccion.movemePara(self,position,1)
		}
		else{
			direccion = direccionesPermitidas.anyOne()
		}
		self.establecerVelocidad()
	}
	method atacar(){}
	method meLlevoPuesto(alguien){
		alguien.perder()
	}
}

object llama inherits Monstruo(image = "LlamaDerecha.png", positionI = game.at(1,12),nombre="Llama",velocidad=1000){
	var baba = null
	override method atacar(){
		baba = new Baba(image = "Baba" + direccion.nombre() + ".png", position = position, direccionDeBaba = direccion)
		game.addVisual(baba)
		game.onTick(250,"moverBaba",{baba.desplazarse()})
	}
} 

object carpincho inherits Monstruo(image = "CarpinchoDerecha.png", positionI = game.at(12,12),nombre = "Carpincho",velocidad = 50){
	const property velocidadInicial = velocidad
	override method atacar(){
		velocidad -=5
	}
	override method meLlevoPuesto(alguien){
		self.sonido().play()
		super(alguien)
		
	}
	method sonido() = soundProducer.sound("risaPatan.mp3")

}
object carpinchoSinSonido inherits Monstruo(image = "CarpinchoDerecha.png", positionI = game.at(12,12),nombre = "Carpincho",velocidad = 50){
	const property velocidadInicial = velocidad
	override method atacar(){
		//velocidad -=5
	}
}
		
class ExplosionCentral inherits ExplosionGenerica{
	const explosionesVinculadas=[]
	
	method mostrar(alcance){
		explosionesVinculadas.add(self)
		(1..alcance).forEach{i=>direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,i)}} 
		explosionesVinculadas.forEach{explosion => self.configurarExplosion(explosion)}
		game.schedule(2000,{self.finDeExplosion()})
	}
		
	method expandirse(direccion,cantidad){
		if(direccion.puedeSeguir(position,cantidad)){
				explosionesVinculadas.add(new ExplosionGenerica(position = direccion.proximaPosicion(position,cantidad))) 
		}
	}
	
	method configurarExplosion(explosion){
		game.addVisual(explosion)
		
		self.sonido().play()
		game.onCollideDo(explosion,{elemento=>self.daniar(elemento)})
	}
	method sonido() = soundProducer.sound("bombaSonidoCorto.mp3")
	method finDeExplosion(){
		explosionesVinculadas.forEach{explosion => game.removeVisual(explosion)}
	}
}
class ExplosionGenerica{
	const property position = null
	method image() = "Explosion0.png"
	method meLlevoPuesto(algo){}
	method daniar(elemento){elemento.meExplotoUnaBombaEncima()}
	method meExplotoUnaBombaEncima(){}
}
//Falta solo mejorar la forma en que la llama escupe
class Baba {
	var property image
	var property position
	const direccionDeBaba
	const nombre = "Baba"
	method perder(){
		game.removeTickEvent("moverBaba")
		game.removeVisual(self)
	}
	method meLlevoPuesto(alguien){
		alguien.perder()
	}
	method desplazarse(){
		
		if(direccionDeBaba.esPosible(position,1)){
			direccionDeBaba.movemePara(self,position,1)
		}
		else{self.perder()}
	}
	
	method direccionarVisual(direccion){
		image = nombre + direccion.nombre() + ".png"
	}
}

object contadorVidas{
	const property position = game.at(0,13)
	var property image = "Vidas3.png"
	const nombre = "Vidas"
	method aparecer(){
		image = "Vidas3.png"
		game.addVisual(self)
	}
	method modificarImagen(vidas){
		if(vidas>0){
			image = nombre + vidas.toString() + ".png"
		}
		else{game.removeVisual(self)}
	}
}
