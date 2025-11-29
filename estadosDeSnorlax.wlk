import snorlax.*
import gestorEstadosDeSnorlax.*

class EstadoSimple {
    const property nombre
    const property duracion = 0
    const property efectos = #{}
    var property modo = desactivado
    const property tipoDeArchivo

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

    method extension() { return tipoDeArchivo.extension() } //por defecto

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
        gestorDeEstados.animarSecuencia(self)
    }

    method cantFramesPorSegundo() { return 1000 / fps }

    override method nombre() { return nombre + "_" + etapaActual }

    override method finalizarAnimacion() {
        gestorDeEstados.finalizarSecuenciaActual()
        super() 
    }

    method avanzarASiguienteEtapa() { etapaActual += 1 }

    override method desactivar() {
        super()
        self.resetear()
    }

    method resetear() { etapaActual = 0 }

    override method duracion() { return cantEtapas * self.cantFramesPorSegundo() }
}

//estados de snorlax
const snorlaxNormal = new EstadoSimple ( 
    nombre = "normal",
    tipoDeArchivo = new ArchivoGIF() 
)

const snorlaxCapturado = new EstadoCompuesto ( 
    nombre = "capturado",
    efectos = #{invulnerabilidad, inmovilidad, desgano },
    cantEtapas = 35,
    fps = 5,
    tipoDeArchivo = new ArchivoPNG()
)

const snorlaxRecibiendoDaño = new EstadoSimple (
    nombre = "daño",
    duracion = 1000,
    tipoDeArchivo = new ArchivoGIF() 
)

const snorlaxPerdedor = new EstadoSimple (
    nombre = "perdedor",
    duracion = 2000,
    tipoDeArchivo = new ArchivoGIF() 
)

const snorlaxGanaNivel = new EstadoSimple (
    nombre = "gana",
    duracion = 1000,
    tipoDeArchivo = new ArchivoGIF() 
)

const snorlaxComiendo = new EstadoSimple ( 
    nombre = "comiendo", 
    duracion = 500,
    tipoDeArchivo = new ArchivoGIF() ,
    efectos = #{ inmovilidad }
)

const snorlaxAdormecido = new EstadoSimple ( 
    nombre = "adormecido", 
    duracion = 8000,
    tipoDeArchivo = new ArchivoGIF() ,
    efectos = #{ desgano } 
)

//efectos
object inmovilidad {}

object desgano {}

object invulnerabilidad {}

//Tipo de archivo admitidos
class TipoDeArchivo { method extension() }

class ArchivoPNG inherits TipoDeArchivo {
    override method extension() { return ".png" }
}

class ArchivoGIF inherits TipoDeArchivo {
    override method extension() { return ".gif" }
}