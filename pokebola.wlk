import snorlax.*
import basura.*
import estadosDeSnorlax.*

class Pokebola inherits Basura {

    override method chocasteConSnorlax() {
        basuraDelJuego.eliminarBasuraDelJuego(self)
        snorlax.validarInvencibilidad()
        snorlaxCapturado.animar()
    }
 
    method nombre() { return "pokebola_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}