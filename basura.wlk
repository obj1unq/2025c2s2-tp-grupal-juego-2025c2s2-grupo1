import personajes.*
import extras.*
import randomizer.*

class Basura {
    const property basura
    var estado = basura.estado() 
    var property position
    const property puntos = basura.puntos()

    method caer() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
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

    method image() { return estado }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        if (snorlax.tieneVidas()) {
            snorlax.perderUnaVida()
            game.schedule(1000, {snorlax.cambiarEstadoA(snorlaxNormal)})
        }
        else {
            puntuacion.incrementaPuntos(puntos)
            snorlax.terminarJuego()
        }
    }

    method eliminarDelJuego() { game.removeVisual(self) }

    method aplicarDañoPorCaida() {
        game.onCollideDo(self, {algo => algo.recibirDaño()})
    }
}

class Bota {
    var faseActual = 1
    const property puntos = -150

    method estado() { return "bota-" + faseActual + ".png" }
}

object basuraDelJuego {
    const property basuraActiva = []

    method nuevaBasura(_basura) { 
        return new Basura( basura = _basura, position = randomizer.emptyPosition())
    }

	method añadirBasuraAlAzar() {
		game.onTick(1500, "añadir basura al azar", {
			self.añadirBasuraAlJuego(self.crearBasura())
		})
	}

	method crearBasura() {
		const basuraElegida = [
                {self.nuevaBasura(new Bota())}].anyOne()

		return basuraElegida.apply()
	}

    method añadirBasuraAlJuego(basura) {
        basuraActiva.add(basura)
        basura.aplicarDañoPorCaida()
        game.addVisual(basura)
    }

    method aplicarGravedadATodaLaBasura() {
        game.onTick(700, "Gravedad en basura", {
                basuraActiva.forEach({ basura => basura.caer() })
            }
        )
    }

    method eliminarBasuraAlJuego(basura) {
        basuraActiva.remove(basura)
        game.removeVisual(basura)
    }
}