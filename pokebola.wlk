import snorlax.*
import basura.*
import estadosDeSnorlax.*

class Pokebola inherits Basura {

    override method chocasteConSnorlax() { 
        self.eliminarDelJuegoEn(250)
        snorlaxCapturado.animacion()
    }
 
    method nombre() { return "pokebola_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}