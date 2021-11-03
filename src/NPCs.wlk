import wollok.game.*
import direcciones.*
import ConfigGen.*
import Obstaculos.*
import soundProducer.*


object bomberman inherits Personaje(image = "bomberman.png", position = game.at(1,0)){
	
	
	var bombasDisponibles = 1
	const bombasPuestas = []
	var alcance = 1
	
	/*method reiniciarPosicion(){//Bomberman vuelve a la posición de inicio
		position=game.at(0,0)
	}*/
	method moverPara(direccion) {
		direccion.movemePara(self,self.position(),1) //las direcciones son quienes se encargan de mover al personaje
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

}



class Explosion{
	var property image = "Explosion0.png"
	var property position = null
	var indice = 1
	const explosionesVinculadas=[]
	method mostrar(alcance){
		explosionesVinculadas.add(self)
		(1..alcance).forEach{i=>direccionesPermitidas.forEach{direccion=>self.expandirse(direccion,i)}} //se podria hacer un game.schedule para que se muestre como animacion??
		explosionesVinculadas.forEach{explosion => self.configurarExplosion(explosion)}
		game.schedule(1500,{self.finDeExplosion()})
	}
	
	
	method expandirse(direccion,cantidad){
		if(direccion.puedeSeguir(position,cantidad)){
				explosionesVinculadas.add(new ExtensionDeExplosion(position = direccion.proximaPosicion(position,cantidad))) 
			//podriamos no mostrar la visual sobre el obstaculo
		}
		else{indice+=1}
	}
	
	method configurarExplosion(explosion){
		game.addVisual(explosion)
		game.sound("bombaSonidoCorto.mp3").play()
		game.onCollideDo(explosion,{elemento=>self.daniar(elemento)})
	}
	
	method efecto(algo){
	}
	method finDeExplosion(){
		explosionesVinculadas.forEach{explosion => game.removeVisual(explosion)}
	}
	method daniar(elemento){elemento.perder()}
}
class ExtensionDeExplosion{
	const property position = null
	method image() = "Explosion0.png"
	method efecto(algo){
	}
	method daniar(elemento){elemento.perder()}
}



class Personaje{ 
	var property image
	var property position
	var property nombre = ""
	var vidas = 3
	method crear(){
		game.addVisual(self)
		
	}
	method perder(){ 
		vidas-=1
		if(vidas<0){
			self.morir()
		}
	}
	method morir(){
		game.removeVisual(self)
		game.clear()
	}
	
	method direccionarVisual(direccion){
		image = nombre + direccion.nombre() + ".png"
	}
}

class Monstruo inherits Personaje{ 
	var property velocidad 
	var direccion = direccionesPermitidas.anyOne()
	override method crear(){
		super()
		game.onTick(velocidad,"moverse",{self.caminar()})
		self.configurar()
		
		
	}
	method configurar(){game.onTick(10,"atacar",{self.atacar()})}
	method caminar(){
		
		if(direccion.esPosible(position,1)){
			direccion.movemePara(self,position,1)
		}
		else{
			direccion = direccionesPermitidas.anyOne()
		}
	}
	method atacar(){}
	method efecto(alguien){
		alguien.perder()
	}
}

object llama inherits Monstruo(image = "LlamaDer.png", position = game.at(1,12),nombre="Llama",velocidad=200){
	var baba = null
	override method atacar(){
		baba = new Baba(image = "BabaDer.png", position = position, direccionDeBaba = direccion)
		game.addVisual(baba)
		babasEnJuego.add(baba)
		//baba.direccionar(direccion)
		
	}
} 
/*
object carpincho inherits Monstruo(image = "carpinchoD.png", position = game.at(12,12),nombre = "carpincho",velocidad = 50){
	const property velocidadInicial = velocidad
	const sonidoMatar=game.sound("risaPatan.mp3")
	override method atacar(){
		velocidad -=5
	}
	override method efecto(alguien){
		sonidoMatar.play()
		super(alguien)
		
	} 
}*/




/*
}

}*/
class Baba {
	var property image
	var property position
	const direccionDeBaba
	method perder(){
		babasEnJuego.remove(self)
		game.removeVisual(self)
	}
	method desplazarse(){
		
		if(direccionDeBaba.esPosible(position,1)){
			direccionDeBaba.movemePara(self,position,1)
		}
		else{self.perder()}
	}
}

