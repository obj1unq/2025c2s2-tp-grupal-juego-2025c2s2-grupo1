import snorlax.*
import basura.*

class Pokeflauta inherits Basura {
    const property puntos = 0

    override method dañar() {
        super()
        puntuacion.incrementaPuntos(self.puntos())
    }

    method nombre() { return "bota_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}