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

    method puedeSubirDeNivel() {
        return puntuacion.puntos() > self.umbralParaSiguienteNivel()
    }

    method actualizarDificultad() {
        juego.removerMecanicas()
        juego.aplicarMecanicas()
        fallingObjectsDelJuego.añadirItemAlAzar()
    }

    method siguienteNivel()

    method umbralParaSiguienteNivel()

    method probabilidad()  

    method tiempo()
}

object nivelFacil inherits Nivel {
    override method probabilidad() { return 25 }

    override method tiempo() { return 0.5 }

    override method fondo() {
        return fondoNivelFacil
    }

    override method umbralParaSiguienteNivel() { return 1000 }

    override method siguienteNivel() { return nivelNormal }
}

object nivelNormal inherits Nivel {
    override method probabilidad() { return 45 }

    override method tiempo() { return 1 }

    override method fondo() {
        return fondoNivelNormal
    }

    override method umbralParaSiguienteNivel() { return 2000 }

    override method siguienteNivel() { return nivelDificil }
}

object nivelDificil inherits Nivel {
    override method probabilidad() { return 60 }

    override method tiempo() { return 1.5 }

    override method fondo() {
        return fondoNivelDificil
    }

    override method umbralParaSiguienteNivel() { return 10**(20) }
    
    override method siguienteNivel() { return nivelFacil }
}
