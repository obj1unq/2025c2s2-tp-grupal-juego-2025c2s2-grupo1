import fallingObjects.*
import pokelitos.*
import comida.*
import snorlax.*
import extras.*
import basura.*
import fasesDelJuego.*

object gameOver{
    const musica = game.sound("game-over.mp3")
    
    method reproducir(){
        musica.play()
    }
    method detener(){
        musica.stop()
    }
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
    const musica = game.sound("musica-juego.mp3")
    
    method reproducir(){
        musica.play()
    }
    method detener(){
        musica.stop()
    }
}
