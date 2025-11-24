import estadosDeSnorlax.*

class TipoAnimacion {
    method iniciar(estado) {
        gestorDeEstados.recordarEstadoActual(estado)
        self.animar(estado)
    }

    method animar(estado)

    method extension()

    method finalizar() {
        gestorDeEstados.finalizar()
    }
}

class AnimacionGif inherits TipoAnimacion {
    override method extension() {
        return ".gif"
    }

    override method animar(estado) {
        gestorDeEstados.iniciarGif(estado)
    }
}

class SecuenciaPng inherits TipoAnimacion {
    const property cantSprites
    var property etapaActual = 0

    override method animar(estado) {
        gestorDeEstados.iniciarAnimacionPng(estado)
    }

    override method extension() {
        return "_" + etapaActual + ".png"
    }

    override method finalizar() {
        gestorDeEstados.finalizarSecuencia()
        super()
        self.reiniciarEtapas()
    }

    method cambiarAlSiguienteSprite() {
        etapaActual = (etapaActual + 1).min(cantSprites) 
    }
    
    method reiniciarEtapas() { etapaActual = 0 }
}