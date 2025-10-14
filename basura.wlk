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
            game.removeVisual(self)
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
        snorlax.perderUnaVida()
        puntuacion.incrementaPuntos(self.puntos())
        self.eliminarDelJuego()
    }

    method eliminarDelJuego() { game.removeVisual(self) }
    
    method chocasteConSnorlax() { snorlax.recibirDaño() }

    method esComida() { return false }
}

class Bota {
    var faseActual = 1
    const property puntos = -150

    method estado() { return "bota-" + faseActual + ".png" }
}

class Pokebola {
    var faseActual = 1
    const property puntos = 0

    method estado() { return "bota-" + faseActual + ".png" }  //CAMBIAR IMAGEN
}

class BolsaDeBasura {
    var faseActual = 1
    const property puntos = 0

    method estado() { return "basura-" + faseActual + ".png" }
}

class Pokeflauta {
    var faseActual = 1
    const property puntos = 0

    method estado() { return "bota-" + faseActual + ".png" }  //CAMBIAR IMAGEN
}

class ManzanaPodrida {
    var faseActual = 1
    const property puntos = 0

    method estado() { return "manzana-podrida-" + faseActual + ".png" }
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
        const basuraElegida = self.elegirSegunProbabilidad()

		return basuraElegida.apply()
	}

    method elegirSegunProbabilidad() { 
        const probabilidad = 0.randomUpTo(100)

        if(probabilidad.between(0, 30)) {
            return {self.nuevaBasura(new Pokeflauta())}
        }
        else if(probabilidad.between(30, 40)) {
            return {self.nuevaBasura(new Pokebola())}
        }
        else if(probabilidad.between(40, 70)){
            return {self.nuevaBasura(new Bota())}
        }
        else if(probabilidad.between(70, 85)) {
            return {self.nuevaBasura(new BolsaDeBasura())}
        } 
        else {
            return {self.nuevaBasura(new ManzanaPodrida())}
        }
    }

    method añadirBasuraAlJuego(basura) {
        basuraActiva.add(basura)
        game.addVisual(basura)
    }

    method aplicarGravedadATodaLaBasura() {
        game.onTick(700, "Gravedad en basura", {
                basuraActiva.forEach({ basura => basura.caer() })
            }
        )
    }

    method aplicarDañoPorCaida() {
         game.onCollideDo(snorlax, { otro => otro.chocasteConSnorlax()})
    }

    method eliminarBasuraAlJuego(basura) {
        basuraActiva.remove(basura)
        game.removeVisual(basura)
    }
}