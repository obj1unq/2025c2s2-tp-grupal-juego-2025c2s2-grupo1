import snorlax.*
import basura.*

class Bota inherits Basura {
    const property puntos = -150

    override method dañar() { 
        puntuacion.incrementaPuntos(self.puntos())
        snorlax.perderUnaVida()
        super()
    }

    method nombre() { return "bota_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}