import extras.*
import comida.*
import basura.*
import estadosDeSnorlax.*
import interfaces.*


object snorlax{
    var property position = game.at(0, 0) 
    var property estado = snorlaxNormal
    var property vidas = 3 //Comienza con 3 vidas
    
    //acciones
    method mover(direccion){
        juego.validarEstado()
        self.validarMover(direccion)
        position = direccion.siguiente(self)
    }

    method recibirDaño() {
        juego.validarEstado()
        self.objetoEnColision().dañar()
        if (self.tieneVidas()) { // no se puede añadir validacion porque interrumpe el flujo.
            snorlaxRecibiendoDaño.animacion()
        }
        else { self.terminarJuego() }
    }

    method terminarJuego() { 
        snorlaxPerdedor.animacion()
        game.schedule(2000, { juego.finalizar() }) 
    }

    method comer(){
        juego.validarEstado()
        self.validarComer()
        self.objetoEnColision().comer()
    }

    method perderUnaVida() { vidas -= 1 }
    
    method ganarUnaVida() { 
        self.validarFaltanVidas()
        vidas += 1
    }

    method cambiarEstadoA(estadoNuevo) { 
        estado = estadoNuevo 
    }

    method levantarComida(comida) {
        estado.validarAdormecimiento()
        comida.cambiarEstadoA(primerEstado)
    }

    method reiniciar() {
        position = game.at(0, 0)
        vidas = 3
        self.cambiarEstadoA(snorlaxNormal)
    }
    
    method subirAlSiguienteNivel() {
        game.schedule(1000, {
            snorlaxGanaNivel.animacion()
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

    method validarVidas() {
        if (not self.tieneVidas()) {
            self.terminarJuego()
        }
    }

    method validarFaltanVidas() {
        if (vidas == 3) {
            self.error("Snorlax tiene vidas suficientes.")
        }
    }

    method validarMover(direccion) {
        if (not self.puedeMover(direccion) || estado.estaInmovilizado()) {
            self.error("No puedo mover.")
        }
    }

    method validarComer() {
        estado.validarAdormecimiento()
        if (not self.hayComidaColisionando()) {
            self.error("No hay nada para comer.")
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

// puntuacion de snorlax

object puntuacion{
    var property puntos = 0
    var property position = game.at(7,8) 
    
    method incrementaPuntos(puntosFruta){
        puntos += puntosFruta
        juego.subirDeNivel()
    } 

    method text() { return self.puntos().toString() }

    method reiniciar() { puntos = 0 }
}

object progressNivel {
    var property position = game.at(7, 6)

    method text() { return juego.nivel().nombre() }
}