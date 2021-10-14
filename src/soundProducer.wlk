import wollok.game.*

// Utilizar este objeto para crear sonidos.
// NO utilizar directamente game.sound(audioFile) porque puede complicarles el testeo
// En su lugar utilicen: soundProducer.sound(audioFile)
// Si sus tests fallan porque les dice que no pueden iniciar sonidos antes de que empiece el juego
// lo que deben hacer es cambiar el proveedor del soundProducer, asi: soundProducer.provider(soundProviderMock)

object backgroundMusic{
	var sonido
	
	method configurarSonido(){
		    sonido = soundProducer.sound("trompetasBoke.mp3")
			//sonido.volume(1)
		}
	method mandaleCumbia(){
		self.configurarSonido()
		sonido.play()
	}
}
object soundProducer {
	
	var provider = game
	
	method provider(_provider){
		provider = _provider
	}
	
	method sound(audioFile) = provider.sound(audioFile)
	
}

object soundProviderMock {
	
	method sound(archivoDeAudio) = soundMock
	
}

object soundMock {
	
	method pause(){}
	
	method paused() = true
	
	method play(){}
	
	method played() = false
	
	method resume(){}
	
	method shouldLoop(looping){}
	
	method shouldLoop() = false
	
	method stop(){}
	
	method volume(newVolume){}
	
	method volume() = 0
}