import snorlax.*
import basura.*

class ManzanaPodrida inherits Basura {

    override method dañar() {
        snorlax.perderUnaVida()
        super()
    }

    method nombre() { return "manzana-podrida_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}