import extras.*
import snorlax.*
import estadosDeSnorlax.*
import pokelitos.*
import randomizer.*
import fallingObjects.*
import pokeBayas.*
import score.*
import factories.*

class Comida inherits FallingObject {
    const property variante
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