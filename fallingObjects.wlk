import extras.*
import personajes.*
import basura.*
import comida.*

class FallingObject {
    var property estado = primerEstado
    var property position
    const property puntos

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

    method colisionaConSnorlax() {
        return position == snorlax.position()
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

	method añadirItemAlJuego() {
		const itemElegido = [
             {comidaDelJuego.añadirComidaAlAzar()}, {basuraDelJuego.añadirBasuraAlAzar()}].anyOne()

		return itemElegido.apply()
	}

    method añadirItemAlAzar() {
        game.onTick(4000, "añadir falling object al azar", {self.añadirItemAlJuego()})
    }

    method aplicarGravedad() {
        game.onTick(4000, "aplicar gravedad", 
            { self.fallingObjectsActivos().forEach({ item => item.caer() }) }
        )
    }

    method aplicarAnimaciones() {
        game.onTick(1000, "aplicar animaciones", 
            { self.fallingObjectsActivos().forEach({ item => item.cambiarAlSiguienteEstado() }) }
        )
    }

    method aplicarColisiones() {
        game.whenCollideDo(snorlax, { otro => otro.chocasteConSnorlax()})
    }
}