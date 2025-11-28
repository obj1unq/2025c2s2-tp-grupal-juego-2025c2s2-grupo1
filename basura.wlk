import snorlax.*
import fallingObjects.*
import bolsaDeBasura.*
import pokeflauta.*
import pokebola.*
import bota.*
import manzanaPodrida.*
import randomizer.*
import factories.*

class Basura inherits FallingObject {
    //acciones
    method dañar() {
        basuraDelJuego.eliminarDelJuego(self)
    }
    
    override method chocasteConSnorlax() { 
        snorlax.recibirDaño()
    }

    override method eliminarDelJuegoEn(ticks) {
        game.schedule(ticks, {basuraDelJuego.eliminarDelJuego(self)})
    }
}
