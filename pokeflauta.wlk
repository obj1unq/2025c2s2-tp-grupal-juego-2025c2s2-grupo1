import snorlax.*
import basura.*

class Pokeflauta inherits Basura {

    override method dañar() { 
        super()
        puntuacion.incrementaPuntos(-(puntuacion.puntos()))
    }

    method nombre() { return "pokeflauta_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}