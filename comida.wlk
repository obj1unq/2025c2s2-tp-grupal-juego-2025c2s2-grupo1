import extras.*
import personajes.*
import pokelitos.*
import randomizer.*

class Comida {
    const property tipoDeComida
    var property estado = primerEstado 
    var property position
    const property puntos = tipoDeComida.puntos()

    //acciones
    method caer() {
        self.validarExistencia()
        self.validarCaida()
        position = position.down(2)
    }

    method comer() {
        snorlaxComiendo.animacion()
        puntuacion.incrementaPuntos(puntos)
        self.eliminarDelJuegoEn(500)
    }

    method eliminarDelJuegoEn(ticks) {
         game.schedule(ticks, {comidaDelJuego.eliminarComidaDelJuego(self)})
    }
    method cambiarAlSiguienteEstado() {
        estado.proximoEstado(self) 
    }// probar con nuevo method
    
    method chocasteConSnorlax() { snorlax.levantarComida(self) }

    method cambiarEstadoA(_estado) { estado = _estado }

    //consultas
    method puedeCaer() {
        return self.estaEnElJuego() and snorlax.tieneVidas()
    }

    method hayCelda(direccion) {
		return (direccion.siguiente(self).y().between(0, game.height()-1))
	}

    method image() { return tipoDeComida.nombre() + estado.nivel() + ".png" }

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

object comidaDelJuego {
    const property comidaActiva = []

    method nuevaComida(_comida) { 
        return new Comida(tipoDeComida = _comida, position = randomizer.emptyPosition())
    }
	
    method nuevoPokelito() {
        return self.nuevaComida(pokelitos.crearPokelito())
    }

	method crearComida() {
		const comidaElegida = [{self.nuevoPokelito()}].anyOne()

		return comidaElegida.apply()
	}

    method añadirComidaAlAzar() {
		game.onTick(4000, "añadir comida al azar", {
			self.añadirComidaAlJuego(self.crearComida())
		})
	}
    
    method añadirComidaAlJuego(comida) {
        comidaActiva.add(comida)
        game.addVisual(comida)
    }

    method aplicarGravedadATodaLaComida() {
        game.onTick(4000, "Gravedad en la Comida", {
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

    method aplicarPropiedadDeLevantarComida() {
        game.whenCollideDo(snorlax, { otro => otro.chocasteConSnorlax()})
    }

    method hayComidaEn(_position) {
        return comidaActiva.any({comida => comida.position() == _position })
    }
}