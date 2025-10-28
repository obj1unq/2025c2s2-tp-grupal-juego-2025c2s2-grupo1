import snorlax.*
import basura.*

class ManzanaPodrida inherits Basura {

    override method dañar() {
        super()
        snorlax.perderUnaVida()
    }

    method nombre() { return "manzana-podrida_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}