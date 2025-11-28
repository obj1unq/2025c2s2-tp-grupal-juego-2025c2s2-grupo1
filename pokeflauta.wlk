import estadosDeSnorlax.*
import snorlax.*
import basura.*
import sound.*
import factories.*

class Pokeflauta inherits Basura {

    method adormecer() { 
        snorlaxAdormecido.animar() 
        gestorMusica.reproducirSonido(sleepSound)
    }

    override method chocasteConSnorlax() { 
        basuraDelJuego.eliminarDelJuego(self)
        self.adormecer()
    }

    method nombre() { return "pokeflauta_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}