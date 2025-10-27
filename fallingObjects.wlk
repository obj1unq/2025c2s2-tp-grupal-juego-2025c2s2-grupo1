import extras.*
import snorlax.*
import basura.*
import comida.*
import randomizer.*

class FallingObject {
    var property estado = primerEstado
    var property position

    //acciones
    method caer() {
        self.validarExistencia()
        self.validarCaida()
        position = position.down(2)
    }

    method cambiarAlSiguienteEstado() {
        estado.proximoEstado(self) 
    }

    method cambiarEstadoA(_estado) { estado = _estado }

    method chocasteConSnorlax()

    method eliminarDelJuegoEn(ticks)

    //consultas

    method puedeCaer() {
        return self.estaEnElJuego() and snorlax.tieneVidas()
    }

    method hayCelda(direccion) {
		return (direccion.siguiente(self).y().between(0, game.height()-1))
	}

    method image()

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    //validaciones
    method validarCaida() {
        if (not self.puedeCaer()) {
            self.error("No puedo seguir cayendo.")
        }
    }

    method validarExistencia() {
        if (not self.hayCelda(abajo)) {
            self.eliminarDelJuegoEn(1500)
        }
    }
}

object fallingObjectsDelJuego {

    method fallingObjectsActivos() {
        return comidaDelJuego.comidaActiva() + basuraDelJuego.basuraActiva()
    }

    method añadirItemAlAzar() {
        game.onTick(1000, "añadir item al azar", {
            self.añadirItemSegunProbabilidad()
        })
    }

    method añadirItemSegunProbabilidad() {
        const probabilidad = 0.randomUpTo(100)

        if(probabilidad.between(0, 50)) {
            basuraDelJuego.añadirBasuraAlAzar()
        }
        else {
            comidaDelJuego.añadirComidaAlAzar()
        }
    }

    method aplicarGravedad() {
        game.onTick(1000, "aplicar gravedad", 
            { self.fallingObjectsActivos().forEach({ item => item.caer() }) }
        )
    }

    method aplicarAnimaciones() {
        game.onTick(250, "aplicar animaciones", 
            { self.fallingObjectsActivos().forEach({ item => item.cambiarAlSiguienteEstado() }) }
        )
    }

    method aplicarColisiones() {
        game.whenCollideDo(snorlax, { otro => otro.chocasteConSnorlax()})
    }
}