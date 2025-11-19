import snorlax.*
import extras.*
import fallingObjects.*
import estadosDelJuego.*
import gameSnorlax.configuraciones
import fondosDelJuego.*
import niveles.*
import estadosDeSnorlax.*
import score.*
import sound.*

object juego {
    var estado = juegoEnPausa
    var nivel = nivelFacil

    //metodos setter y getter
    method cambiarEstadoA(estadoNuevo) { estado = estadoNuevo }

    method estado() { return estado }
    method nivel() { return nivel }

    method alternarEstado() { estado.alternarEstado() }

    method cambiarNivelA(_nivel) { nivel = _nivel }

    method cambiarAlSiguienteNivel() {
        self.cambiarNivelA(nivel.siguienteNivel())
    }

    /*method cambiarMusicaAInGame() {
        configuraciones.musicaActual().detener()
        musicJuego.reproducir()
    }*/

    //metodos de cambio de fase del juego.
    method comenzar() { //Cambia de Pantalla de Inicio a Juego (inGame)
        pantallaDeInicio.removerFondo()
        self.configurarTeclas()
        musicJuego.reproducir()
        self.inicializar()
    }

    method reiniciar() { //Cambia de Pantalla de GameOver a Juego (inGame)
        highscore.actualizar()
        puntuacion.reiniciar()
        progressLevel.reiniciar()
        self.cambiarNivelA(nivelFacil)
        nivel.removerFondo() // por alguna razón, tengo que remover el fondo del nivel facil pese a que se remueve al subir de nivel.
        pantallaDeFin.removerFondo()
        musicGameOver.detener()
        musicJuego.reproducir()
        self.inicializar()
    }

    method finalizar() { //Cambia de Juego(inGame) a Pantalla de GameOver (juegoEnPausa)
        musicJuego.detener()
        musicGameOver.reproducir()
        self.alternarEstado()
        self.removerTodosLosVisuales()
        self.removerMecanicas()
        pantallaDeFin.inicializar()
    }

    method subirDeNivel() {
        self.validarSubirDeNivel()
        self.alternarEstado()
        self.removerMecanicas()
        snorlax.subirAlSiguienteNivel()
        self.inicializarNivel()
    }

    method inicializarNivel() {
        game.schedule(2000, {
            self.removerVisualesActivos()
            nivel.inicializar()
            self.alternarEstado()
            game.addVisual(snorlax)
        })
    }

    method inicializar() {
        configuraciones.cambiarEstadoA(self)
        nivel.añadirFondo()
        self.añadirVisuales()
        self.aplicarMecanicas()
        self.alternarEstado()
    }

    //configuraciones del juego
    method configurarTeclas() { //detenerse cuando esta en pausa
        keyboard.a().onPressDo({snorlax.mover(izquierda)}) 
        keyboard.d().onPressDo({snorlax.mover(derecha)})
        keyboard.space().onPressDo({snorlax.comer()})
        //keyboard.m().onPressDo({ snorlax.mutear() })
        //Se intentó añadir boton de pausar y reanudar pero no se logró solucionar el bug con las animaciones.
    }

    method añadirVisuales() {
        game.addVisual(snorlax)
        game.addVisual(puntuacion)
        game.addVisual(vida)
        game.addVisual(nivelActual)
        game.addVisual(progressLevel)
        game.addVisual(highscore)
        fallingObjectsDelJuego.añadirItemAlAzar() //detenerse cuando esta en pausa
    }

    method removerTodosLosVisuales() {
        self.removerVisualesActivos()
        game.removeVisual(puntuacion)
        game.removeVisual(vida)
        game.removeVisual(nivelActual)
        game.removeVisual(progressLevel)
        game.removeVisual(highscore)
    }

    method removerVisualesActivos() {
        game.removeVisual(snorlax)
        fallingObjectsDelJuego.removerTodo()
        nivel.removerFondo()
    }

    method aplicarMecanicas() {
        fallingObjectsDelJuego.aplicarGravedad()
        fallingObjectsDelJuego.aplicarAnimaciones()
        fallingObjectsDelJuego.aplicarColisiones()
    }

    method removerMecanicas() {
        game.removeTickEvent("aplicar gravedad")
        game.removeTickEvent("aplicar animaciones")
        game.removeTickEvent("añadir item al azar")
    }

    //validaciones
    method jugar() { //No me convence pues ya está inicializar(). Este metodo lo añadí por polimorfismo.
        self.error("El juego ya está corriendo.")
    }

    method validarEstado() {
        estado.validarEstado()
    }

    method validarSubirDeNivel() {
        if (not nivel.puedeSubirDeNivel()) {
            self.error("No se puede subir de nivel.")
        }
    }

    method validarFaseDelJuego() {} //no ocurre nada

    method musica() { musicJuego }
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

    method musica() { return musicJuego }
}

object pantallaDeInicio inherits PantallaDelJuego {
    override method fondo() { return fondoDeInicio }

    override method jugar() { juego.comenzar() }

    override method musica() { return musicGameOver } //temporal
}

object pantallaDeFin inherits PantallaDelJuego {
    override method fondo() { return fondoDeGameOver }

    override method jugar() { juego.reiniciar() }

    override method musica() { return musicGameOver }
}