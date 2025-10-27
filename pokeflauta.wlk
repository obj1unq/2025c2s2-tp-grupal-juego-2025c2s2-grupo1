import snorlax.*
import basura.*

class Pokeflauta inherits Basura {

    // override method dañar() { falta desarrollar
    //     // super()
    //     // game.schedule(1000, {self.ralentizarPersonaje()})
    // }

    method nombre() { return "pokeflauta_" } 

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}