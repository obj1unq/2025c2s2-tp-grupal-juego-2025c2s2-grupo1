import fallingObjects.*
import pokelitos.*
import comida.*
import snorlax.*
import extras.*
import basura.*
import fasesDelJuego.*
import gameSnorlax.*

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
    const volumen

    override method reproducir(){
        musica = self.sonido()
        musica.volume(volumen)
        musica.shouldLoop(true)
        musica.play()
    }

    override method detener(){
        musica.shouldLoop(false)
        musica.stop()
    }
}


const gameStartMusic = new SonidoBackground( nombre = "musica-inicio.mp3", volumen = 1 )
const gameOverMusic  = new SonidoBackground( nombre = "musica-fin.mp3", volumen = 1) //demasiado corto
const inGameMusic    = new SonidoBackground( nombre = "musica-juego.mp3", volumen = 0.3)
const harmSound      = new SonidoEfecto( nombre = "harming-sound.mp3" )
const eatSound       = new SonidoEfecto( nombre = "eating-sound.mp3" )


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
