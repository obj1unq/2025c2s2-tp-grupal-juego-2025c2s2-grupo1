import snorlax.*
import estadosDeSnorlax.*

object gestorDeEstados {
    var duracionRestante = 0

    method animarSecuenciaPNGs(estado) {
        self.prepararEstado(estado)
        self.comenzarSecuencia(estado)
    }

    method comenzarSecuencia(estado) {
        game.onTick(estado.cantFramesPorSegundo(), "Secuencia de PNGs", { 
            estado.avanzarASiguienteEtapa()
            self.verificarTimer()
        })
    }

    method prepararEstado(estado) {
        snorlax.cambiarEstadoA(estado)
        estado.activar()
        self.finalizarTimerActual()
        self.iniciarTimer(estado.duracion())
    }

    method extenderDuracion() {
        duracionRestante += self.estadoActual().duracion()
    }

    method verificarSiHayInterrupcion() {
        if (not self.seAgotoLaDuracion()) {
            gestorInterrupciones.registrarInterrupcionNueva(duracionRestante)
            self.estadoActual().desactivar()
        }
    }

    method iniciarTimer(duracion) {
        duracionRestante = duracion
        self.activarTimer()
    }

    method activarTimer() {
        game.onTick(500, "Timer", {
            self.decrementarTimer()
            self.verificarTimer()
        })
    }

    method decrementarTimer() {
        duracionRestante = (duracionRestante - 500).max(0)
    }

    method verificarTimer() {
        if (self.seAgotoLaDuracion()) { self.estadoActual().finalizarAnimacion() }
    }

    method determinarFinalizacion() {
        if (gestorInterrupciones.hayInterrupciones()) {
            gestorInterrupciones.continuarEstadoInterrumpido()
        } else { self.terminar() } 
    }

    method finalizarSecuenciaActual() {
        game.removeTickEvent("Secuencia de PNGs")
    }

    method finalizarTimerActual() {
        game.removeTickEvent("Timer")
    }

    method terminar() {
        self.estadoActual().desactivar()
        snorlax.cambiarEstadoA(snorlaxNormal)
    }

    method estadoActual() { return snorlax.estado() }

    method duracion() { return duracionRestante }

    method seAgotoLaDuracion() { return duracionRestante == 0 }
}

object gestorInterrupciones {
    const interrupciones = []

    method hayInterrupciones() { return not interrupciones.isEmpty() }

    method crearInterrupcion(duracionRestante) { 
        return new Interrupcion(
            estadoInterrumpido = snorlax.estado(), 
            duracionRestante = duracionRestante
        )
    }

    method registrarInterrupcionNueva(duracionRestante) {
        interrupciones.add(self.crearInterrupcion(duracionRestante))
    }

    method continuarEstadoInterrumpido() {
        self.ultimaInterrupcion().continuar()
        self.eliminarTodo()
    }

    method ultimaInterrupcion() { return interrupciones.last() }

    method eliminarTodo() { interrupciones.clear() }
}

class Interrupcion {
    const property estadoInterrumpido
    const property duracionRestante

    method continuar() {
        snorlax.validarInvencibilidad()
            snorlax.cambiarEstadoA(estadoInterrumpido)
            estadoInterrumpido.activar()
        gestorDeEstados.iniciarTimer(duracionRestante) 
    }
}

class ModosDeEstado {
    method animar(estado)

    method validarActivacion() {}

    method validarDesactivacion() {}
}

object activado inherits ModosDeEstado {
    override method animar(estado) {
        gestorDeEstados.extenderDuracion()
    }

    override method validarActivacion() {
        self.error("Ya está activado.")
    }
}

object desactivado inherits ModosDeEstado {
    override method animar(estado) {
        gestorDeEstados.verificarSiHayInterrupcion()
        estado.iniciarAnimacion()
    }

    override method validarDesactivacion() {
        self.error("Ya está desactivado.")
    }
}