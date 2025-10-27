import snorlax.*
import basura.*

class Bota inherits Basura {
    const property puntos = -150

    override method dañar() {  //Saca vidas y descuenta puntos????
        super()
        puntuacion.incrementaPuntos(self.puntos())
        snorlax.perderUnaVida()
    }

    method nombre() { return "bota_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}