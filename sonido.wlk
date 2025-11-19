import fallingObjects.*
import pokelitos.*
import comida.*
import snorlax.*
import extras.*
import basura.*
import fasesDelJuego.*




class Sonido {
    const nombre
    
    method reproducir()

    method detener()

    method sonido() { return game.sound(nombre) }
}

class SonidoEfecto inherits Sonido {
    override method reproducir(){
        self.sonido().play()
    }

    override method detener(){
        self.sonido().stop()
    }
}

class SonidoBackground inherits Sonido {
    var musica = null

    override method reproducir(){
        musica = self.sonido()
        musica.shouldLoop(true)
        musica.play()
    }

    override method detener(){
        musica.shouldLoop(false)
        musica.stop()
    }
}

object sonidos{ 
    method reproducirMusicFinal() {
        musicJuego.detener()
        musicGameOver.reproducir()
    }

    method reproducirMusicJuegoDespuesDe(musica) {
        musica.detener()
        musicJuego.reproducir()
    }
}

/*
    musicInicio => musicJuego => musicFin => musicJuego => musicFinal

*/


const musicGameOver =   new SonidoBackground(nombre = "game-over.mp3")
const musicDeathSound = new SonidoEfecto(nombre = "death-sound.mp3")
const musicJuego = new SonidoBackground(nombre = "musica-juego.mp3")



/*
object gameOver{
    var property musica = null
    const property nombre = "game-over.mp3"
    
    method reproducir(){
        musica = self.sonido()
        musica.shouldLoop(true)
        musica.play()
    }
    method detener(){
        musica.shouldLoop(false)
        musica.stop()
    }

    method sonido() { return game.sound(nombre) }
}

object deathSound{
    const musica = game.sound("death-sound.mp3")
    
    method reproducir(){
        musica.play()
    }
    method detener(){
        musica.stop()
    }
}

object musicJuego{
    var property musica = game.sound("musica-juego.mp3")
    
    method reproducir(){
        musica = game.sound("musica-juego.mp3")
        musica.shouldLoop(true)
        musica.play()
    }
    method detener(){
        musica.shouldLoop(false)
        musica.stop()
    }
}*/
