import snorlax.*
import extras.*
import fallingObjects.*
import estadosDelJuego.*

object juego {
    var estado = juegoEnPausa
    //var nivel = nivelFacil

    method cambiarEstadoA(estadoNuevo) {
        estado = estadoNuevo
    }

    method estado() { return estado }

    method comenzar() {
        pantallaDeInicio.removerFondo()
        self.configurarTeclas()
        self.añadirVisuales()
        self.añadirFondo()
        self.aplicarMecanicas()
        self.alternarEstado()
    }

    method reiniciar() {
        fallingObjectsDelJuego.removerTodo()
        snorlax.reiniciar()
        puntuacion.reiniciar()
        pantallaDeFin.removerFondo()
        self.alternarEstado()
    }

    method finalizar() {
        self.alternarEstado()
        pantallaDeFin.inicializar()
    }

    method alternarEstado() { estado.alternarEstado() }

    method configurarTeclas() { //detenerse cuando esta en pausa
        keyboard.a().onPressDo({snorlax.mover(izquierda)}) 
        keyboard.d().onPressDo({snorlax.mover(derecha)})
        keyboard.space().onPressDo({snorlax.comer()})
    }

    method añadirVisuales() {
        game.addVisual(snorlax)
        game.addVisual(puntuacion)
        game.addVisual(vida)
        fallingObjectsDelJuego.añadirItemAlAzar() //detenerse cuando esta en pausa
    }

    method añadirFondo() {} //Varia segun el nivel

    method aplicarMecanicas() { //detenerse cuando esta en pausa
        fallingObjectsDelJuego.aplicarGravedad()
        fallingObjectsDelJuego.aplicarAnimaciones()
        fallingObjectsDelJuego.aplicarColisiones()
    }

    method validarEstado() {
        estado.validarEstado()
    }
}

//Pantallas del juego
class PantallaDelJuego {
    //Metodos Template
    method añadirFondo() {
        game.addVisual(self.fondo())
    }
    
    method removerFondo() {
        game.removeVisual(self.fondo())
    }

    method configurarTeclas() {
        keyboard.enter().onPressDo({
            //validacion
            self.jugar()
        })
    }

    //Metodos Hook
    method jugar()

    method fondo()

    method inicializar() {
        self.añadirFondo()
        self.configurarTeclas()
    }
}

object pantallaDeInicio inherits PantallaDelJuego {
    override method fondo() { return fondoDeInicio }

    override method jugar() { juego.comenzar() }
}

object pantallaDeFin inherits PantallaDelJuego {
    override method fondo() { return fondoDeGameOver }

    override method jugar() { juego.reiniciar() }
}

//Fondos de Pantalla
object fondoDeInicio {
    const property position = game.origin()

    method image() { return "fondoGameStart.png"}
}

object fondoDeGameOver {
    const property position = game.origin()

    method image() { return "fondoGameOver.png"}
}