import snorlax.*
import gestorEstadosDeSnorlax.*

class EstadoSimple {
    const property nombre
    const property duracion = 0
    const property efectos = #{}
    var property modo = desactivado

    method animar() { modo.animar(self) }

    method iniciarAnimacion() {
        gestorDeEstados.prepararEstado(self)
    }

    method activar() {
        modo.validarActivacion()
        modo = activado
    }

    method desactivar() {
        modo.validarDesactivacion()
        modo = desactivado
    }

    method tieneEfecto(efecto) {
        return efectos.contains(efecto)
    }

    method extension() { return ".gif" } //por defecto

    method finalizarAnimacion() {
        gestorDeEstados.finalizarTimerActual()
        gestorDeEstados.determinarFinalizacion()
    }
}

class EstadoCompuesto inherits EstadoSimple {
    const cantEtapas
    var etapaActual = 0
    const fps

    override method iniciarAnimacion() {
        gestorDeEstados.animarSecuenciaPNGs(self)
    }

    method cantFramesPorSegundo() { return 1000 / fps }

    override method nombre() { return nombre + "_" + etapaActual }

    override method finalizarAnimacion() {
        gestorDeEstados.finalizarSecuenciaActual()
        super() 
    }

    override method extension() { return ".png" }

    method avanzarASiguienteEtapa() { etapaActual += 1 }

    override method desactivar() {
        super()
        self.resetear()
    }

    method resetear() { etapaActual = 0 }

    override method duracion() { return cantEtapas * self.cantFramesPorSegundo() }
}

//estados de snorlax
const snorlaxNormal = new EstadoSimple ( nombre = "normal" )

const snorlaxCapturado = new EstadoCompuesto ( 
    nombre = "capturado",
    efectos = #{invulnerabilidad, inmovilidad, desgano },
    cantEtapas = 35,
    fps = 5
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

const snorlaxComiendo = new EstadoSimple ( 
    nombre = "comiendo", 
    duracion = 500,
    efectos = #{ inmovilidad }
)

const snorlaxAdormecido = new EstadoSimple ( 
    nombre = "adormecido", 
    duracion = 8000,
    efectos = #{ desgano } 
)

//efectos
object inmovilidad {}

object desgano {}

object invulnerabilidad {}