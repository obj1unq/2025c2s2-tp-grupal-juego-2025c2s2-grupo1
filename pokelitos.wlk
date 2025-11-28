import snorlax.*
import extras.*
import comida.*
import randomizer.*
import score.*
import variantesComida.*


//pokelitos
class Pokelito inherits Comida {

    method nombre() { return "pokelito-" + variante.nombre() }

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}
