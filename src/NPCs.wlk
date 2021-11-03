import wollok.game.*
import direcciones.*
import ConfigGen.*
import Obstaculos.*
import soundProducer.*


object bomberman inherits Personaje(image = "bomberman.png", position = game.at(1,0)){
	
	const property esPP = true
	var bombasDisponibles = 1
	const bombasPuestas = []
	var alcance = 1
	
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
			//if (direccion.esPosible(position,cantidad)){
				explosionesVinculadas.add(new ExtensionDeExplosion(position = direccion.proximaPosicion(position,cantidad))) 
			//}
			/*else{
				explosionesVinculadas.add(new ObjetoInvisible(direccion.proximaPosicion(position,cantidad)))
			}*/ //ESTO ME ESTA ROMPIENDO seria para no mostrar la visual sobre el obstaculo
		}
		else{indice+=1}
	}
	
	method configurarExplosion(explosion){
		game.addVisual(explosion)
		game.sound("bombaSonidoCorto.mp3").play()
		//game.onCollideDo(explosion,{elemento=>elemento.perder()})
	}
	
	method efecto(algo){
		algo.perder()
	}
	method finDeExplosion(){
		explosionesVinculadas.forEach{explosion => game.removeVisual(explosion)}
	}
}
class ExtensionDeExplosion{
	const property esPP = false
	const property position = null
	method image() = "Explosion0.png"
	method efecto(alguien){
		alguien.perder()
	}
}
	
class ObjetoInvisible{
	const property position = null
}



class Personaje{ 
	var property image = null
	var property position = null
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
	}
	
	method direccionarVisual(direccion){
		image = nombre + direccion.nombre() + ".png"
	}
}

class Monstruo inherits Personaje{ //forma de codear al monstruo segun Rodri
	var velocidad 
	var direccion = direccionesPermitidas.anyOne()
	override method crear(){
		super()
		game.onTick(velocidad,"moverse",{self.caminar()})
	}
	method caminar(){
		
		if(direccion.esPosible(position,1)){
			direccion.movemePara(self,position,1)
		}
		else{
			direccion = direccionesPermitidas.anyOne()
		}
	}
	method atacar()
	method efecto(alguien){
		alguien.perder()
	}
}

object llama inherits Monstruo(image = "LlamaDer.png", position = game.at(12,1),nombre="Llama",velocidad=100){
	const babas = []
	override method atacar(){
		babas.add(1) //Esto lo puse para despues, no tiene sentido alguno
		//babas.add(new Baba())
	}
} 
object carpincho inherits Monstruo(image = "carpinchoD.png", position = game.at(12,12),nombre = "carpincho",velocidad = 100){
	const property velocidadInicial = velocidad
	const sonidoMatar=game.sound("risaPatan.mp3")
	override method atacar(){
		velocidad -=5
	}
	override method efecto(alguien){
		sonidoMatar.play()
		super(alguien)
		
	} 
}








class Monstruo2{ //forma de codear al monstruo segun Ger
	var property imageI = null
	var property imageD = null
	var property image = null
	var property position = null
	const movimiento = null
	const mata = null
	const sonidoMatar=null
	method imageI()=imageI
	method imageD()=imageD
	method sonidoMatar()=sonidoMatar
	method posicion()=position
	method imageActual(imageActual){image=imageActual}
	method posicionar(posicion){position=posicion}
//Monstruo hace perder a bomberman	
	method matar(){
		if(self.posicion()==bomberman.position()){
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
	method crear(){
		game.addVisual(self)
	}
}

//Mata monstruos, no lo apliqué a bomberman.
object muerte{
	method a(personaje){
		game.removeVisual(personaje)
	}

}

const carpincho1 = new Monstruo2 (imageI = "carpinchoI.png",imageD = "carpinchoD.png",image="carpinchoI.png", position = game.at(12,12),movimiento= "carpincho1Moving",mata="carpincho1Asesino",sonidoMatar="risaPatan.mp3")
const carpincho2 = new Monstruo2 (imageI = "carpinchoI.png",imageD = "carpinchoD.png",image="carpinchoI.png", position = game.at(7,4),movimiento="carpincho2Moving",mata="carpincho2Asesino",sonidoMatar="risaPatan.mp3")
const direccionamientoCarpincho1 = new Direccionamiento(direction=left,nextPosition=left.next(carpincho1))
const direccionamientoCarpincho2 = new Direccionamiento (direction=left,nextPosition=left.next(carpincho2))

/* 
class MonstruoADistancia inherits Monstruo{
	method escupir(){
		const baba = new Baba()
		game.addVisual(baba)
		babaEnJuego.add(baba)
	}
}

class Baba{
	var property imageI = null
	var property imageD = null
	var property image = imageI
	var property position = null
	method posicion()=position
	method imageActual(imageActual){image=imageActual}
	method posicionar(posicion){position=posicion}
	
}
	LLAMA
	method escupir(){
		if(direccion == "derecha"){
			const baba = new Baba(direccion = direccion, position = position, image = "BabaDer.png")
		}
		else {
			const baba = new Baba(direccion = direccion, position = position, image = "BabaIzq.png")
		}
		game.addVisual(baba)
		babaEnJuego.add(baba)
	}
}

class Baba{
	var property direccion = null
	var property position = null
	var property image = null
	var property posicionAnterior = game.at(0,0)
	var property posicionSiguiente = game.at(0,0)
	
	method avanzar(){
		if(direccion == "derecha"){
			posicionAnterior = position
			posicionSiguiente = derecha.proximaPosicion(position)
			position = posicionSiguiente
		}
		else {
			posicionAnterior = position
			posicionSiguiente = izquierda.proximaPosicion(position)
			position = posicionSiguiente
		}
	}
}*/
