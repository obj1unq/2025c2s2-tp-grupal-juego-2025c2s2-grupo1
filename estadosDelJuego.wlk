import fallingObjects.*
import interfaces.*
import gameSnorlax.configuraciones

object juegoInGame {
    method alternarEstado() {
        juego.cambiarEstadoA(juegoEnPausa)
    }

    method reanudar() { 
        self.error("No se puede reanudar porque el juego ya está corriendo.") 
    }

    method pausar() {
        configuraciones.validarEstado()
        self.alternarEstado()
        juego.removerMecanicas()
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

    method reanudar() {
        configuraciones.validarEstado()
        self.alternarEstado()
        
        juego.aplicarMecanicas()
        fallingObjectsDelJuego.añadirItemAlAzar()
    }

    method pausar() { self.error("No se puede pausar ya que está en pausa.") }
}