import gestorEstadosDeSnorlax.*
import snorlax.*
import basura.*
import estadosDeSnorlax.*
import factories.*

class Pokebola inherits Basura {

    override method chocasteConSnorlax() {
        basuraDelJuego.eliminarDelJuego(self)
        snorlax.validarEfecto(invulnerabilidad)
        snorlaxCapturado.animar()
    }
 
    method nombre() { return "pokebola_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}