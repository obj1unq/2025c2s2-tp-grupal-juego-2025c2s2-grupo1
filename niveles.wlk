import fallingObjects.*
import fondosDelJuego.*
import interfaces.*
import snorlax.*

class Nivel {
    method fondo() 

    method inicializar() {
        self.añadirFondo()
        self.actualizarDificultad()
    }

    method añadirFondo() {
        game.addVisual(self.fondo())
    }

    method removerFondo() {
        game.removeVisual(self.fondo())
    }

    method actualizarDificultad() {
        fallingObjectsDelJuego.modificarSpawneoBasura(self.probabilidad())
        fallingObjectsDelJuego.modificarVelocidadDeCaida(self.velocidadDeCaida())
    }

    method puedeSubirDeNivel() {
        return puntuacion.puntos() > self.umbralParaSiguienteNivel()
    }

    method siguienteNivel()

    method umbralParaSiguienteNivel()

    method probabilidad()  

    method velocidadDeCaida()
}

object nivelFacil inherits Nivel {
    override method probabilidad() { return 25 }

    override method velocidadDeCaida() { return 1 }

    override method fondo() {
        return fondoNivelFacil //temporal
    }

    override method umbralParaSiguienteNivel() { return 1000 }

    override method siguienteNivel() { return nivelNormal }
}

object nivelNormal inherits Nivel {
    override method probabilidad() { return 50 }

    override method velocidadDeCaida() { return 2 }

    override method fondo() {
        return fondoNivelNormal //temporal
    }

    override method umbralParaSiguienteNivel() { return 2000 }

    override method siguienteNivel() { return nivelDificil }
}

object nivelDificil inherits Nivel {
    override method probabilidad() { return 75 }

    override method velocidadDeCaida() { return 3 }

    override method fondo() {
        return fondoNivelFacil //temporal
    }

    override method umbralParaSiguienteNivel() { return 10**(20) }
    
    override method siguienteNivel() { return nivelFacil }
}
