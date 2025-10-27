import snorlax.*
import basura.*

class BolsaDeBasura inherits Basura {

    override method dañar() {
        super()
        snorlax.perderUnaVida()
    }

    method nombre() { return "bolsaDeBasura_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}