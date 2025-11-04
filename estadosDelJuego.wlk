import fallingObjects.*
import interfaces.*
import gameSnorlax.configuraciones

object juegoInGame {
    method alternarEstado() {
        juego.cambiarEstadoA(juegoEnPausa)
    }

    method validarEstado() {// no ocurre nada
    }

    method pausar() {
        self.alternarEstado()
        game.removeTickEvent("aplicar gravedad")
        game.removeTickEvent("aplicar animaciones")
        game.removeTickEvent("añadir item al azar")
    }
}

object juegoEnPausa {
    method alternarEstado() {
        juego.cambiarEstadoA(juegoInGame)
    }

    method validarEstado() {
        self.error("El juego está en pausa.")
    }

    method reanudar() {
        configuraciones.validarEstado()
        fallingObjectsDelJuego.aplicarAnimaciones()
        fallingObjectsDelJuego.aplicarGravedad()
    }
}