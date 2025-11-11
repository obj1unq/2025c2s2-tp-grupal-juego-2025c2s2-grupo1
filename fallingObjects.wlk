import extras.*
import snorlax.*
import basura.*
import comida.*
import randomizer.*
import interfaces.*

class FallingObject {
    var property estado = primerEstado
    var property position

    //acciones
    method caer() {
        //juego.validarEstado()
        self.validarExistencia()
        self.validarCaida()
        position = position.down(2)
    }

    method cambiarAlSiguienteEstado() {
        //juego.validarEstado()
        self.validarVidas()
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

    method validarVidas() {
        if (!snorlax.tieneVidas()) {
            self.error("Snorlax no tiene mas vidas.")
        }
    }
}

object fallingObjectsDelJuego {

    method fallingObjectsActivos() {
        return comidaDelJuego.comidaActiva() + basuraDelJuego.basuraActiva()
    }

    method removerTodo() {
        comidaDelJuego.removerTodo()
        basuraDelJuego.removerTodo()
    }

    method tiempoDeCaida() { return 1000 / juego.nivel().tiempo() }

    method probabilidadDeSpawneoBasura() { return juego.nivel().probabilidad() }

    method añadirItemAlAzar() {
        game.onTick(self.tiempoDeCaida(), "añadir item al azar", {
            self.añadirItemSegunProbabilidad()
        })
    }

    method añadirItemSegunProbabilidad() {
        const probabilidad = 0.randomUpTo(100)

        juego.validarEstado()
        if(probabilidad.between(0, self.probabilidadDeSpawneoBasura())) {
            basuraDelJuego.añadirBasuraAlAzar()
        }
        else {
            comidaDelJuego.añadirComidaAlAzar()
        }
    }

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