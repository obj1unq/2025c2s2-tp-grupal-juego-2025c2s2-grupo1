import snorlax.*
import basura.*

class Pokebola inherits Basura {

    override method dañar() {
        super()
        snorlax.efectoInmovilizador(true)
        game.schedule(8000, {snorlax.efectoInmovilizador(false)})
    }

    override method chocasteConSnorlax() { 
        snorlaxCapturado.animacion() 
    }

    method nombre() { return "pokebola_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}