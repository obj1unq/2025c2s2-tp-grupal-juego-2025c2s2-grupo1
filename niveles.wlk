import fallingObjects.*
import fondosDelJuego.*
import interfaces.*

class Nivel {
    method fondo() 

    method inicializar() {
        self.añadirFondo()
        self.actualizarDificultad()
    }

    method añadirFondo() {
        game.addVisual(self.fondo())
    }

    method actualizarDificultad() {
        fallingObjectsDelJuego.modificarSpawneoBasura(self.probabilidad())
        fallingObjectsDelJuego.modificarVelocidadDeCaida(self.velocidadDeCaida())
    }

    method probabilidad()  

    method velocidadDeCaida()
}

object nivelFacil inherits Nivel {
    override method probabilidad() { return 25 }

    override method velocidadDeCaida() { return 1 }

    override method fondo() {
        return fondoNivelFacil //temporal
    }
}

object nivelNormal inherits Nivel {
    override method probabilidad() { return 50 }

    override method velocidadDeCaida() { return 2 }

    override method fondo() {
        return fondoNivelFacil //temporal
    }
}

object nivelDificil inherits Nivel {
    override method probabilidad() { return 75 }

    override method velocidadDeCaida() { return 3 }

    override method fondo() {
        return fondoNivelFacil //temporal
    }
}
