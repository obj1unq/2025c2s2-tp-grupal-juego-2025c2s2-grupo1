import personajes.*
import assetsComida.*
import extras.*

//pokelitos

object pokelitoFrutilla {
    var estado = pokelitoFrutillaAsset1
<<<<<<< HEAD
    var property position = game.at(0, 8)
    var property puntos = 150 
=======
    var property position = game.at(0, 9)
    const puntos = 150 
>>>>>>> 0cfd1b0 (puntuacion lista)
    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

    method puedeMover(direccion) { return self.hayCelda(direccion) and self.estaEnElJuego()}

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}

    method image() {
        return estado.nombre() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        snorlax.sumarPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
} 

object pokelitoLimon {
    var estado = pokelitoLimonAsset1
<<<<<<< HEAD
    var property position = game.at(1, 8)
    var property puntos = 100 
=======
    var property position = game.at(1, 9)
    const puntos = 100 
>>>>>>> 0cfd1b0 (puntuacion lista)

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

    method puedeMover(direccion) { return self.hayCelda(direccion) and self.estaEnElJuego()}

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}


    method image() {
        return estado.nombre() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        snorlax.sumarPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

object pokelitoNaranja {
    var estado = pokelitoNaranjaAsset1
<<<<<<< HEAD
    var property position = game.at(2, 8)
    var property puntos = 200 
=======
    var property position = game.at(2, 9)
    const puntos = 200 
>>>>>>> 0cfd1b0 (puntuacion lista)

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

    method puedeMover(direccion) { return self.hayCelda(direccion) and self.estaEnElJuego()}

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}


    method image() {
        return estado.nombre() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self })
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        snorlax.sumarPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

object pokelitoDulceDeLeche {
    var estado = pokelitoDulceDeLecheAsset1
<<<<<<< HEAD
    var property position = game.at(3, 8)
    var property puntos = 250 
=======
    var property position = game.at(3, 9)
    const puntos = 250 
>>>>>>> 0cfd1b0 (puntuacion lista)

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

    method puedeMover(direccion) { return self.hayCelda(direccion) and self.estaEnElJuego()}

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}


    method image() {
        return estado.nombre() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self })
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        snorlax.sumarPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

object pokelitoChocolate {
    var estado = pokelitoChocolateAsset1
<<<<<<< HEAD
    var property position = game.at(4, 8)
    var property puntos = 250
=======
    var property position = game.at(4, 9)
    const puntos = 250
>>>>>>> 0cfd1b0 (puntuacion lista)

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

    method puedeMover(direccion) { return self.hayCelda(direccion) and self.estaEnElJuego()}

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}


    method image() {
        return estado.nombre() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self })
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        snorlax.sumarPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

