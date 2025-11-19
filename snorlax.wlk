import sound.*
import extras.*
import comida.*
import basura.*
import estadosDeSnorlax.*
import fasesDelJuego.*
import score.*


object snorlax{
    var property position = game.at(0, 0) 
    var property estado = snorlaxNormal
    var property vidas = 3 //Comienza con 3 vidas
    
    //acciones
    method mover(direccion){
        juego.validarEstado()
        self.validarInvencibilidad()
        self.validarMover(direccion)
        position = direccion.siguiente(self)
    }

    method recibirDaño() {
        juego.validarEstado()
        self.validarInvencibilidad()
        self.objetoEnColision().dañar()
        musicDeathSound.reproducir()
        if (self.tieneVidas()) { // no se puede añadir validacion porque interrumpe el flujo.
            snorlaxRecibiendoDaño.animar()
        }
        else { self.terminarJuego() }
    }

    method terminarJuego() { 
        snorlaxPerdedor.animar()
        game.schedule(2000, { juego.finalizar() }) 
    }

    method comer() {
        juego.validarEstado()
        self.validarComer()
        self.objetoEnColision().comer()
    }

    method perderUnaVida() { vidas -= 1 }
    
    method ganarUnaVida() { //No se puede añadir validacion dado que interrumpe flujo en comer()
        if (not self.tieneVidaLlena()) { vidas += 1 }
    }

    method cambiarEstadoA(estadoNuevo) { 
        estado = estadoNuevo 
    }

    method levantarComida(comida) {
        estado.validarAdormecimiento()
        self.validarInvencibilidad()

        comida.cambiarEstadoA(primerEstado)
    }

    method reiniciar() {
        position = game.at(0, 0)
        vidas = 3
        self.cambiarEstadoA(snorlaxNormal)
    }
    
    method subirAlSiguienteNivel() {
        game.schedule(1000, {
            snorlaxGanaNivel.animar()
            progressLevel.reiniciar()
            juego.cambiarAlSiguienteNivel()
        })
    }

    //consultas
    method puedeMover(direccion){
        return self.hayCelda(direccion) && self.tieneVidas()
    }

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-4)
    }

    method tieneVidas() { return vidas > 0 }

    method esInvencible() { return estado.estaInmovilizado() }

    method hayComidaColisionando() { return comidaDelJuego.hayComidaEn(position) }

    method objetoEnColision() { return game.uniqueCollider(self) }

    method image() {
        return "snorlax-" + estado.nombre() + ".png"
    }

    method tieneVidaLlena() {
        return vidas == 3
    }

    method validarVidas() {
        if (not self.tieneVidas()) {
            self.error("Snorlax no tiene vidas.")
        }
    }

    method validarMover(direccion) {
        if (not self.puedeMover(direccion)) {
            self.error("No puedo mover.")
        }
    }

    method validarComer() {
        estado.validarAdormecimiento()
        if (not self.hayComidaColisionando()) {
            self.error("No hay nada para comer.")
        }
    }

    method validarInvencibilidad() {
        if (self.esInvencible()) {
            self.error("Soy invencible.")
        }
    }
}

// Visualizador de vidas
object vida {
    var property position = game.at(7,9)

    method image() {
        return "vidas_" + snorlax.vidas() + ".png"
    }
}