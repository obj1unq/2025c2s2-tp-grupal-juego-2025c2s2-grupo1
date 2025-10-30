import interfaces.*
object juegoInGame {
    method cambiarEstado() {
        juego.cambiarEstadoA(juegoEnPausa)
        self.pausar()
    }

    method pausar() {
        
    }
}

object juegoEnPausa {
    method cambiarEstado() {
        juego.cambiarEstadoA(juegoInGame)
        self.reanudar()
    }

    method reanudar() {

    }
}