import snorlax.*
import basura.*

class Bota inherits Basura {
    const property puntos = -150

    override method dañar() {
        super()
        puntuacion.incrementaPuntos(self.puntos())
    }

    method nombre() { return "bota_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}