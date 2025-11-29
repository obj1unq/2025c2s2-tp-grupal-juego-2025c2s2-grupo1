import fallingObjects.*
import snorlax.*
import extras.*
import fasesDelJuego.*
import gameSnorlax.configuraciones

object gestorMusica {
    var temaActual = gameStartMusic
    var musicaActual = self.audio(temaActual)

    method cambiarASiguienteCancion() {
        self.quitarMuteSiHay() //Si no se quita la pausa durante el cambio de fase se rompe el juego.
        self.detenerActual()
        self.reproducirNextMusic()
    }

    method configurarTeclaMute() {
        keyboard.m().onPressDo({self.mutear()})
    }

    method mutear() {
        if (self.estaPausado()) {
            self.validarMute() //Tuve que añadir una validación dado que extrañamente se ejecutan ambos flujos al ejecutarlo
            self.resumir()
        }
        else {
            self.pausar()
        }
    }

    method quitarMuteSiHay() {
        if (self.estaPausado()) { self.mutear() }
    }

    method estaPausado() {
        return musicaActual.paused()
    }

    method pausar() { musicaActual.pause() }

    method resumir() { musicaActual.resume() }


    method reproducirNextMusic() {
        self.reproducir(configuraciones.nextMusic())
    }

    method audio(tema) {
        return game.sound(tema.nombre())
    }

    method reproducir(tema) {
        musicaActual = self.audio(tema)
        musicaActual.volume(tema.volumen())
        musicaActual.shouldLoop(true)
        musicaActual.play()
    }

    method detenerActual() {
        musicaActual.shouldLoop(false)
        musicaActual.stop()
    }

    method reproducirSonido(sonido) {
        self.audio(sonido).play()
    }

    method validarMute() {
        if (not self.estaPausado()) {
            self.error("La musica ya esta corriendo.")
        }
    }
}


class Audio {
    const property nombre
    const property volumen = 1
}

const gameStartMusic = new Audio( nombre = "musica-inicio.mp3", volumen = 0.3)
const gameOverMusic  = new Audio( nombre = "musica-fin.mp3"    ) //demasiado corto
const inGameMusic    = new Audio( nombre = "musica-juego.mp3",  volumen = 0.3)
const harmSound      = new Audio( nombre = "harming-sound.mp3" )
const eatSound       = new Audio( nombre = "eating-sound.mp3"  )
const levelUpSound   = new Audio( nombre = "levelUp-sound.mp3" )
const sleepSound     = new Audio( nombre = "sleep-sound.mp3"   )
