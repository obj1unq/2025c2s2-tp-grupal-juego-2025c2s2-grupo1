import estadosDeSnorlax.*
import snorlax.*
import basura.*

class Pokeflauta inherits Basura {

    method adormecer() { snorlaxAdormecido.iniciar() }

    override method chocasteConSnorlax() { 
        basuraDelJuego.eliminarBasuraDelJuego(self)
        self.adormecer()
    }

    method nombre() { return "pokeflauta_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}