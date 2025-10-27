import snorlax.*
import basura.*

class Pokebola inherits Basura {

    override method chocasteConSnorlax() { 
        self.eliminarDelJuegoEn(250)
        self.inmovilizarSnorlax()
        snorlaxCapturado.animacion()
    }

    method inmovilizarSnorlax() {
        snorlax.estaInmovilizado(true) 
        game.schedule(10000, {snorlax.estaInmovilizado(false)})
    }
 
    method nombre() { return "pokebola_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}