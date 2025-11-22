import snorlax.*
import tiposDeAnimacion.*

object gestorDeEstados {
    var duracionEstadoActual = 0

    method iniciarGif(estado) {
        duracionEstadoActual = estado.duracion()
        self.iniciarTimer(estado)
        snorlax.cambiarEstadoA(estado)
    }

    method iniciarAnimacionPng(estado) {
        duracionEstadoActual = estado.duracion()
        self.iniciarTimer(estado)
        snorlax.cambiarEstadoA(estado)
        self.iniciarSecuencia(estado)
    }

    method iniciarSecuencia(estado) {
        game.onTick(500, "Animar por secuencia de PNGs", 
            {estado.tipoAnimacion().cambiarAlSiguienteSprite()}    
        )
    }

    method iniciarTimer(estado) {
        game.onTick(500, "Decrementar Timer", {self.decrementarTimer(estado)} )
    }

    method decrementarTimer(estado) {
        self.validarEfectoActual(estado)
        duracionEstadoActual = (duracionEstadoActual - 500).max(0)
        self.validarTimer(estado)
    }

    method unSegundo() { return 1000 }

    method validarTimer(estado) {
        if (duracionEstadoActual == 0) { estado.finalizarAnimacion() }
    }

    method finalizar() {
        self.finalizarTimer()
        snorlax.cambiarEstadoA(snorlaxNormal)
    }

    method continuarEfecto(efecto) {
        duracionEstadoActual = efecto.last()
        snorlax.cambiarEstadoA(efecto.first())
        self.iniciarTimer(efecto.first())
    }

    method finalizarTimer() {
        game.removeTickEvent("Decrementar Timer")
    }

    method finalizarSecuencia() {
        game.removeTickEvent("Animar por secuencia de PNGs")
    }

    method estadoActual() {
        return snorlax.estado()
    }

    method duracion() { return duracionEstadoActual }

    method validarEfectoActual(estado) {
        if (self.estadoActual() != estado) {
            self.error("No es el mismo efecto.")
        }
    }

    method interrumpirEfectoCon(estadoEntrante) {
        const efecto = [self.estadoActual(), duracionEstadoActual]
        self.iniciarEstadoSegunAnimacion(estadoEntrante)
        game.schedule(estadoEntrante.duracion(), {
                self.validarEfectoActual(estadoEntrante)
                self.continuarEfecto(efecto)
            }
        )
    }

    method iniciarEstadoSegunAnimacion(estado) {
        estado.tipoAnimacion().iniciar(estado)
    }
}

class EstadoBase {
    const nombre
    const property duracion = 0
    const property tipoAnimacion
    const property estaInmovilizado = false

    method iniciar() {}

    method validarAdormecimiento() {}

    method finalizarAnimacion() { tipoAnimacion.finalizar() }

    method nombre() { return nombre + tipoAnimacion.extension() }
}

class EstadoDuradero inherits EstadoBase {
    override method iniciar() {
        tipoAnimacion.iniciar(self)
    }
}

class EstadoTemporal inherits EstadoBase {
    override method iniciar() {
        gestorDeEstados.interrumpirEfectoCon(self)
    }
}

const snorlaxNormal = new EstadoBase (
    nombre = "normal",
    tipoAnimacion = new AnimacionGif()
)

const snorlaxCapturado = new EstadoDuradero ( //No se pudo resolver problema con snorlax-capturado.gif
    nombre = "capturado",
    duracion = 18000,
    tipoAnimacion = new SecuenciaPng(cantSprites = 33),
    estaInmovilizado = true
)

const snorlaxComiendo = new EstadoTemporal (
    nombre = "come",
    duracion = 500,
    tipoAnimacion = new AnimacionGif()
)

const snorlaxRecibiendoDaño = new EstadoTemporal (
    nombre = "daño",
    duracion = 1000,
    tipoAnimacion = new AnimacionGif()
)

const snorlaxPerdedor = new EstadoDuradero (
    nombre = "perdedor",
    duracion = 3000,
    tipoAnimacion = new AnimacionGif()
)

const snorlaxGanaNivel = new EstadoDuradero (
    nombre = "gana",
    duracion = 1000,
    tipoAnimacion = new AnimacionGif()
)

object snorlaxAdormecido inherits EstadoDuradero(
    nombre = "adormecido", duracion = 8000, tipoAnimacion = new AnimacionGif()) {

    override method validarAdormecimiento() {
        self.error("No puede comer mientras esta con sueño.")
    }
}