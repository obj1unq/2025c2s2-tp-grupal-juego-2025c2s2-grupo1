import snorlax.*
import basura.*

class Bota inherits Basura {
    override method dañar() { 
        snorlax.perderUnaVida()
        super()
    } //Se elimina atributo puntos por falta de solución.

    method nombre() { return "bota_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}