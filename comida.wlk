import personajes.*
import extras.*
import randomizer.*

//pokelitos
class Pokelito {
    const property gusto
    var estado = gusto.estado() 
    var property position
    const property puntos = gusto.puntos()

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

    method image() { return estado }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        puntuacion.incrementaPuntos(puntos)
    }

    method eliminarDelJuegoEn(ticks) {
        game.schedule(ticks, {pokelitos.eliminarPokelitoAlJuego(self)})
    }
}

class Frutilla {
    var faseActual = 1
    const property puntos = 150

    method estado() { return "frutilla-" + faseActual + ".png" }
}

class Limon {
    var faseActual = 1
    const property puntos = 100

    method estado() { return "limon-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}

class Naranja {
    var faseActual = 1
    const property puntos = 200

    method estado() { return "naranja-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}

class DulceDeLeche {
    var faseActual = 1
    const property puntos = 250

    method estado() { return "dulceDeLeche-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}

class Chocolate {
    var faseActual = 1
    const property puntos = 250

    method estado() { return "chocolate-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}


object pokelitos {
    const property pokelitosActivos = []

    method nuevoPokelito(_gusto) { 
        return new Pokelito( gusto = _gusto, position = randomizer.emptyPosition())
    }

	method añadirPokelitoAlAzar() {
		game.onTick(1500, "añadir comida al azar", {
			self.añadirPokelitoAlJuego(self.crearPokelito())
		})
	}

	method crearPokelito() {
		const pokelitoElegido = [
                {self.nuevoPokelito(new Frutilla())}, {self.nuevoPokelito(new Limon())},
                {self.nuevoPokelito(new Naranja())}, {self.nuevoPokelito(new DulceDeLeche())},
                {self.nuevoPokelito(new Chocolate())}].anyOne()

		return pokelitoElegido.apply()
	}

    method añadirPokelitoAlJuego(pokelito) {
        pokelitosActivos.add(pokelito)
        game.addVisual(pokelito)
    }

    method aplicarGravedadATodosLosPokelitos() {
        game.onTick(700, "Gravedad en pokelitos", {
                pokelitosActivos.forEach({ pokelito => pokelito.caer() })
            }
        )
    }

    method eliminarPokelitoAlJuego(pokelito) {
        pokelitosActivos.remove(pokelito)
        game.removeVisual(pokelito)
    }
}

/* Para probabilidad:
			method factoryElegida() {
				const probabilidad = 0.randomUpto(1)

				if (probabilidad.between(0, 0.15)) {
					return {alpisteFactory.crear()}
				}
				else { return {manzanaFactory.apply()} }
			}
		*/