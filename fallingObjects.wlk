import extras.*
import snorlax.*
import basura.*
import comida.*
import randomizer.*
import fasesDelJuego.*
import factories.*

class FallingObject {
    const property variante
    var property estado = primerEstado
    var property position

    //acciones
    method caer() {
        self.validarExistencia()
        self.validarCaida()
        position = position.down(2)
    }

    method cambiarAlSiguienteEstado() {
        snorlax.validarVidas()
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

    method image() {
        return self.nombre() + estado.nivel() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method nombre()

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
        return self.gestoresFactory().map({factory => factory.itemsActivos() }).flatten()
    }

    method removerTodo() {
        self.gestoresFactory().forEach({ factory => factory.removerTodo() })
    }

    method tiempoDeCaida() { return 1000 / juego.nivel().tiempoCaida() }

    method añadirItemAlAzar() {
        game.onTick(self.tiempoDeCaida(), "añadir item al azar", { self.añadirItemSegunProbabilidad() })
    }

    method añadirItemSegunProbabilidad() {
        const gestorElegido = self.gestoresFactory().anyOne()

        juego.validarEstado()
        snorlax.validarVidas()
        gestorElegido.añadirAlAzar()
    }

    method gestoresFactory() { return [basuraDelJuego, comidaDelJuego] }

    method aplicarGravedad() {
        game.onTick(self.tiempoDeCaida(), "aplicar gravedad", 
            { self.fallingObjectsActivos().forEach({ item => item.caer() }) }
        )
    }

    method aplicarAnimaciones() {
        game.onTick(self.tiempoDeCambioEnAnimacion(), "aplicar animaciones", 
            { self.fallingObjectsActivos().forEach({ item => item.cambiarAlSiguienteEstado() }) }
        )
    }
    
    method tiempoDeCambioEnAnimacion() { return self.tiempoDeCaida() / 4 }

    method aplicarColisiones() {
        game.whenCollideDo(snorlax, { otro => otro.chocasteConSnorlax()})
    }//Debe ser whenCollideDo dado que levantarComida() debe estar ejecutandose continuamente. No afecta a basura.
}