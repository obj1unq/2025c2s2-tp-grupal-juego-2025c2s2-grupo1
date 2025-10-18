import personajes.*
import extras.*
import randomizer.*

class Basura {
    const property basura
    var property position
    const property puntos = basura.puntos()
    var property estado = primerEstado

    //acciones
    method caer() {
        self.validarCaida()
        self.validarExistencia()
        position = abajo.siguiente(self)
    }
    
    method dañar() {
        snorlax.perderUnaVida()
        puntuacion.incrementaPuntos(self.puntos())
        basuraDelJuego.eliminarBasuraDelJuego(self)
    }
    
    method chocasteConSnorlax() { snorlax.recibirDaño() }

    method cambiarAlSiguienteEstado() {
        estado.proximoEstado(self) 
    }

    //consultas
    method image() { return basura.nombre() + estado.nivel() + ".png"}
    
    method puedeCaer() {
        return self.estaEnElJuego() and snorlax.tieneVidas() and self.hayCelda(abajo)
    }

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}

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
            basuraDelJuego.eliminarBasuraDelJuego(self)
        }
    }
}

class Bota {
    const property puntos = -150

    method nombre() { return "bota_" } 
}

class Pokebola {
    const property puntos = 0

    method nombre() { return "bota_" }  //CAMBIAR IMAGEN
}

class BolsaDeBasura {
    const property puntos = 0

    method nombre() { return "bota_" }
}

class Pokeflauta {
    const property puntos = 0

    method nombre() { return "bota_" }  //CAMBIAR IMAGEN
}

class ManzanaPodrida {
    const property puntos = 0

    method nombre () { return "bota_" }
}


object basuraDelJuego {
    const property basuraActiva = []

    method nuevaBasura(_basura) { 
        return new Basura( basura = _basura, position = randomizer.emptyPosition())
    }

	method añadirBasuraAlAzar() {
		game.onTick(4000, "añadir basura al azar", {
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
        game.onTick(2000, "Gravedad en basura", {
                basuraActiva.forEach({ basura => basura.caer() })
            }
        )
    }

    method aplicarAnimacionesATodaLaComida() {
        game.onTick(1000, "Animaciones a la Comida", {
                basuraActiva.forEach({ comida => comida.cambiarAlSiguienteEstado() })
            }
        )
    }

    method aplicarDañoPorCaida() {
         game.onCollideDo(snorlax, { otro => otro.chocasteConSnorlax()})
    }

    method eliminarBasuraDelJuego(basura) {
        basuraActiva.remove(basura)
        game.removeVisual(basura)
    }

    method eliminarTodaLaBasura() {
        basuraActiva.forEach({basura => self.eliminarBasuraDelJuego(basura)})
    }
}