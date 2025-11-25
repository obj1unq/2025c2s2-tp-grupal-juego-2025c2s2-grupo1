import snorlax.*

object gestorDeEstados {
    var duracionRestante = 0

    method animar(estado) {
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
            gestorInterrupciones.crearInterrupcion(duracionRestante)
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
        if (self.seAgotoLaDuracion()) { self.finalizarEstadoActual() }
    }

    method determinarFinalizacion() {
        if (gestorInterrupciones.hayInterrupciones()) {
            gestorInterrupciones.continuarEstadoInterrumpido()
        } else { self.terminar() } 
    }

    method finalizarEstadoActual() {
        self.finalizarTimerActual()
        self.determinarFinalizacion()
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
        const nuevaInterrucion = new Interrupcion(
            estadoInterrumpido = snorlax.estado(), duracionRestante = duracionRestante)
        
        interrupciones.add(nuevaInterrucion)
    }

    method continuarEstadoInterrumpido() {
        self.ultimaInterrupcion().continuar()
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
        gestorInterrupciones.eliminarTodo()
        gestorDeEstados.iniciarTimer(duracionRestante) 
    }
}

class EstadoSimple {
    const property nombre
    const property duracion = 0
    const property estaInmovilizado = false
    var property modo = desactivado

    method animar() { modo.animar(self) }

    method validarAdormecimiento() {}

    method activar() {
        modo.validarActivacion()
        modo = activado
    }

    method desactivar() {
        modo.validarDesactivacion()
        modo = desactivado
    }

    method extension() { return ".gif" } //por defecto
}

class EstadoCompuesto inherits EstadoSimple {
    var cantEtapas
    var etapaActual = 0
    var FPS

    override method animar() {
        super()
        self.comenzar()
    }

    method comenzar() {
        game.onTick(self.cantFramesPorSegundo(), "Animacion", { 
            self.avanzarASiguienteEtapa()
            self.validarFinalizacion()
        })
    }

    method cantFramesPorSegundo() {
        return 1000 / FPS
    }

    method validarFinalizacion() {
        if (gestorDeEstados.seAgotoLaDuracion()) { self.finalizar() }
    }

    override method nombre() {
        return nombre + "_" + etapaActual
    }

    method finalizar() {
        self.terminarAnimacion()
        self.resetear()
    }

    method terminarAnimacion() {
        game.removeTickEvent("Animacion")
    }

    override method extension() { return ".png" }

    method avanzarASiguienteEtapa() { etapaActual += 1 }

    method resetear() { etapaActual = 0 }

    override method duracion() { return cantEtapas * self.cantFramesPorSegundo() }
}

const snorlaxNormal = new EstadoSimple ( nombre = "normal" )

const snorlaxCapturado = new EstadoCompuesto ( 
    nombre = "capturado",
    estaInmovilizado = true,
    cantEtapas = 35,
    FPS = 5
)

const snorlaxComiendo = new EstadoSimple (
    nombre = "come",
    duracion = 500
)

const snorlaxRecibiendoDaño = new EstadoSimple (
    nombre = "daño",
    duracion = 1000
)

const snorlaxPerdedor = new EstadoSimple (
    nombre = "perdedor",
    duracion = 3000
)

const snorlaxGanaNivel = new EstadoSimple (
    nombre = "gana",
    duracion = 1000
)

object snorlaxAdormecido inherits EstadoSimple( nombre = "adormecido", duracion = 8000 ) {

    override method validarAdormecimiento() {
        self.error("No puede comer mientras esta con sueño.")
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
        gestorDeEstados.animar(estado)
    }

    override method validarDesactivacion() {
        self.error("Ya está desactivado.")
    }
}