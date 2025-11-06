import fallingObjects.*
import interfaces.*
import gameSnorlax.configuraciones

object juegoInGame {
    method alternarEstado() {
        juego.cambiarEstadoA(juegoEnPausa)
    }

    method validarEstado() {}
}

object juegoEnPausa {
    method alternarEstado() {
        juego.cambiarEstadoA(juegoInGame)
    }

    method validarEstado() {
        self.error("El juego está en pausa.")
    } // es para las mecanicas
}