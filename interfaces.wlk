import snorlax.*
import extras.*
import fallingObjects.*
import estadosDelJuego.*
import gameSnorlax.configuraciones

object juego {
    var estado = juegoEnPausa
    //var nivel = nivelFacil

    method cambiarEstadoA(estadoNuevo) {
        estado = estadoNuevo
    }

    method estado() { return estado }

    method comenzar() {
        pantallaDeInicio.removerFondo()
        configuraciones.cambiarEstadoA(self)
        self.configurarTeclas()
        self.añadirFondo()
        self.inicializar()
    }

    method reiniciar() {
        snorlax.reiniciar()
        puntuacion.reiniciar()
        pantallaDeFin.removerFondo()
        self.inicializar()
    }

    method finalizar() {
        self.alternarEstado()
        self.removerVisuales()
        self.removerMecanicas()
        pantallaDeFin.inicializar()
    }

    method inicializar() {
        configuraciones.cambiarEstadoA(self)
        self.añadirVisuales()
        self.aplicarMecanicas()
        self.alternarEstado()
    }

    method alternarEstado() { estado.alternarEstado() }

    method configurarTeclas() { //detenerse cuando esta en pausa
        keyboard.a().onPressDo({snorlax.mover(izquierda)}) 
        keyboard.d().onPressDo({snorlax.mover(derecha)})
        keyboard.space().onPressDo({snorlax.comer()})
        //Se intentó añadir boton de pausar y reanudar pero no se logró solucionar las bug con las animaciones.
    }

    method añadirVisuales() {
        game.addVisual(snorlax)
        game.addVisual(puntuacion)
        game.addVisual(vida)
        fallingObjectsDelJuego.añadirItemAlAzar() //detenerse cuando esta en pausa
    }

    method removerVisuales() {
        game.removeVisual(snorlax)
        game.removeVisual(puntuacion)
        game.removeVisual(vida)
        fallingObjectsDelJuego.removerTodo()
    }

    method añadirFondo() {} //Varia segun el nivel

    method aplicarMecanicas() { //detenerse cuando esta en pausa
        fallingObjectsDelJuego.aplicarGravedad()
        fallingObjectsDelJuego.aplicarAnimaciones()
        fallingObjectsDelJuego.aplicarColisiones()
    }

    method removerMecanicas() {
        game.removeTickEvent("aplicar gravedad")
        game.removeTickEvent("aplicar animaciones")
        game.removeTickEvent("añadir item al azar")
    }

    method jugar() { //No me convence pues ya está inicializar(). Este metodo lo añadí por polimorfismo.
        self.error("El juego ya está corriendo.")
    }

    method validarEstado() {
        estado.validarEstado()
    }

    method validarFaseDelJuego() {} //no ocurre nada
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
            configuraciones.iniciarJuego()
        })
    }

    method inicializar() {
        configuraciones.cambiarEstadoA(self)
        self.añadirFondo()
        self.configurarTeclas()
    }

    method jugar()

    //Metodos Hook
    method fondo()
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
class Fondo {
    const property position = game.origin()

    method chocasteConSnorlax() {} //En caso de que snorlax esté en la misma celda donde aparece una pantalla.

    method image() { return self.fondo() }

    method fondo()
}

object fondoDeInicio inherits Fondo {
    override method fondo() { return "fondoGameStart.png" }
}

object fondoDeGameOver inherits Fondo {
    override method fondo() { return "fondoGameOver.png" }
}