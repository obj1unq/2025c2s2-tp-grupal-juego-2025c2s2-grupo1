import snorlax.*
import fallingObjects.*
import bolsaDeBasura.*
import pokeflauta.*
import pokebola.*
import bota.*
import manzanaPodrida.*
import randomizer.*

class Basura inherits FallingObject {
    //acciones
    method dañar() {
        basuraDelJuego.eliminarBasuraDelJuego(self)
    }
    
    override method chocasteConSnorlax() { snorlax.recibirDaño() }

    override method eliminarDelJuegoEn(ticks) {
        game.schedule(ticks, {basuraDelJuego.eliminarBasuraDelJuego(self)})
    }
}

object basuraDelJuego {
    const property basuraActiva = []

    method nuevaPokeflauta() {
        return new Pokeflauta( position = randomizer.emptyPosition() )
    }

    method nuevaPokebola() {
        return new Pokebola( position = randomizer.emptyPosition() )
    }

    method nuevaBota() {
        return new Bota( position = randomizer.emptyPosition() )
    }

    method nuevaBolsaDeBasura() {
        return new BolsaDeBasura( position = randomizer.emptyPosition() )
    }

    method nuevaManzanaPodrida() {
        return new ManzanaPodrida( position = randomizer.emptyPosition() )
    }

	method añadirBasuraAlAzar() {
		self.añadirBasuraAlJuego(self.crearBasura())
	}

	method crearBasura() {
        const basuraElegida = self.elegirSegunProbabilidad()

		return basuraElegida.apply()
	}

    method elegirSegunProbabilidad() { 
        const probabilidad = 0.randomUpTo(100)

        if(probabilidad.between(0, 20)) {
            return {self.nuevaPokeflauta()}
        }
        else if(probabilidad.between(20, 80)) {
            return {self.nuevaPokebola()}
        }
        else if(probabilidad.between(81, 85)){
            return {self.nuevaBota()}
        }
        else if(probabilidad.between(85, 89)) {
            return {self.nuevaBolsaDeBasura()}
        } 
        else {
            return {self.nuevaManzanaPodrida()}
        }
    }

    method añadirBasuraAlJuego(basura) {
        basuraActiva.add(basura)
        game.addVisual(basura)
    }

    method eliminarBasuraDelJuego(basura) {
        basuraActiva.remove(basura)
        game.removeVisual(basura)
    }
}