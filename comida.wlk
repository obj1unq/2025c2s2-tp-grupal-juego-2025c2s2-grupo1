import extras.*
import snorlax.*
import estadosDeSnorlax.*
import randomizer.*
import fallingObjects.*
import score.*
import factories.*

class Comida inherits FallingObject {
    const property puntos = variante.puntos()

    //acciones
    method comer() {
        snorlaxComiendo.animar()
        self.eliminarDelJuegoEn(500)
        puntuacion.incrementaPuntos(puntos)
    }

    override method eliminarDelJuegoEn(ticks) {
         game.schedule(ticks, {comidaDelJuego.eliminarDelJuego(self)})
    }

    override method chocasteConSnorlax() { snorlax.levantarComida(self) }
}

class Pokelito inherits Comida {
    override method nombre() { return "pokelito-" + variante.nombre() }
}

class Baya inherits Comida {
    override method comer() {
        snorlax.ganarUnaVida()
        super()
    }

    override method nombre() { return "baya-" + variante.nombre() }
}