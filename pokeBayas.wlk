import snorlax.*
import extras.*
import comida.*
import randomizer.*
import score.*
import variantesComida.*


class Baya inherits Comida {
    override method comer() {
        snorlax.ganarUnaVida()
        super()
    }

    method nombre() { return "baya-" + variante.nombre() }

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}