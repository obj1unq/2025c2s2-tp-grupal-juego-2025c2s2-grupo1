import snorlax.*
import fasesDelJuego.*

const colorTexto = "FFFFFFFF"

//Visualizadores relacionados a la puntuación
object puntuacion {
    var property puntos = 0
    var property position = game.at(7,8) 
    
    method incrementaPuntos(puntosObjetenidos){
        puntos += puntosObjetenidos
        progressLevel.incrementarPuntos(puntosObjetenidos)
        juego.subirDeNivel()
    } 

    method text() { return self.puntos().toString() }

    method textColor() {return colorTexto }

    method reiniciar() { puntos = 0 }
}

object highscore {
    var property highscore = 0
    var property position = game.at(7, 6) 
    
    method actualizar() {
        if (self.seBateRecord()) { //No se puede poner una validación dado que corta el flujo en juego.reiniciar()
            highscore = puntuacion.puntos()
        }
    }

    method seBateRecord() {
        return puntuacion.puntos() > highscore
    }

    method text() { return self.highscore().toString() }

    method textColor() {return colorTexto }
}

//Visualizadores relacionados al nivel
object nivelActual {
    var property position = game.at(7, 7)

    method text() { return juego.nivel().nombre() }

    method textColor() {return colorTexto }
}

object progressLevel {
    var property position = game.at(8, 7)
    var property puntos = 0

    method text() { return self.progresoActual().toString() + "%" }

    method textColor() {return colorTexto }

    method progresoActual() {
        return self.porcentajeActual().min(100)
    }

    method porcentajeActual() {
        return ((puntos / self.puntosParaSiguienteNivel()) *100).round()
    }

    method puntosParaSiguienteNivel() {
        return juego.nivel().puntosMinimosParaNextLevel()
    }

    method incrementarPuntos(puntosObjetenidos) {
        puntos += puntosObjetenidos
    }

    method reiniciar() { puntos = 0 }
}