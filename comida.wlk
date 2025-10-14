import extras.*
import personajes.*
import pokelitos.*
import randomizer.*

class Comida {
    const property tipoDeComida
    var estado = primerEstado 
    var property position
    const property puntos = tipoDeComida.puntos()

    method caer() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            self.eliminarDelJuegoEn(1500)
        }
    } 

    method puedeMover(direccion) { 
        return self.hayCelda(direccion) and self.estaEnElJuego() and snorlax.tieneVidas()
    }

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}

    method image() { return tipoDeComida.nombre() + estado.nivel() + ".png" }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        snorlaxComiendo.animacion()
        puntuacion.incrementaPuntos(puntos)
        estado = primerEstado
        self.eliminarDelJuegoEn(500)
    }

    method eliminarDelJuegoEn(ticks) {
         game.schedule(ticks, {comidaDelJuego.eliminarComidaDelJuego(self)})
    }

    method esComida() { return true }

    method chocasteConSnorlax() { /* nada */ }

    method cambiarAlSiguienteEstado() { 
        if ((not self.estaSobreElSuelo())) {
            estado = estado.proximoEstado() 
        }
        else { estado = quintoEstado }
    }

    method estaSobreElSuelo() {
        return (self.tieneEstado(segundoEstado) ) && (not self.hayCelda(abajo))
    }

    method tieneEstado(_estado) { return estado == _estado }
}

object comidaDelJuego {
    const property comidaActiva = []

    method nuevaComida(_comida) { 
        return new Comida(tipoDeComida = _comida, position = randomizer.emptyPosition())
    }

	method añadirComidaAlAzar() {
		game.onTick(2000, "añadir comida al azar", {
			self.añadirComidaAlJuego(self.crearComida())
		})
	}

	method crearComida() {
		const comidaElegida = [
                {self.nuevaComida(pokelitos.crearPokelito())}
                ].anyOne()

		return comidaElegida.apply()
	}

    method añadirComidaAlJuego(comida) {
        comidaActiva.add(comida)
        game.addVisual(comida)
    }

    method aplicarGravedadATodaLaComida() {
        game.onTick(2000, "Gravedad en la Comida", {
                comidaActiva.forEach({ comida => comida.caer() })
            }
        )
    }

    method eliminarComidaDelJuego(comida) {
        comidaActiva.remove(comida)
        game.removeVisual(comida)
    }

    method aplicarAnimacionesATodaLaComida() {
        game.onTick(1000, "Animaciones a la Comida", {
                comidaActiva.forEach({ comida => comida.cambiarAlSiguienteEstado() })
            }
        )
    }
}