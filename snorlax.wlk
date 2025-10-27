import extras.*
import comida.*
import basura.*


object snorlax{
    var property position = game.at(0, 0) 
    var property estado = snorlaxNormal
    var property estaInmovilizado = false  
    var property vidas = 3 //Comienza con 3 vidas
    
    //acciones
    method mover(direccion){
        self.validarMover(direccion)
        position = direccion.siguiente(self)
    }

    method recibirDaño() {
        self.objetoEnColision().dañar()
        if (self.tieneVidas()) { // no se puede añadir validacion porque no interrumpe el flujo.
            snorlaxRecibiendoDaño.animacion()
        }
        else { self.terminarJuego() }
    }

    method terminarJuego() { 
        snorlaxPerdedor.animacion()
        game.schedule(2000, { game.stop() }) 
    }

    method comer(){
        self.validarComer()
        self.objetoEnColision().comer()
    }

    method perderUnaVida() { vidas -= 1 }

    method cambiarEstadoA(estadoNuevo) { estado = estadoNuevo }

    method levantarComida(comida) {
        comida.cambiarEstadoA(primerEstado)
    }

    //consultas
    method puedeMover(direccion){
        return self.hayCelda(direccion) && self.tieneVidas()
    }

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }

    method tieneVidas() { return vidas > 0 }

    method esInvencible() { return estaInmovilizado }

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

    method validarMover(direccion) {
        if (not self.puedeMover(direccion) || self.estaInmovilizado()) {
            self.error("No puedo mover.")
        }
    }

    method validarComer() {
        if (not self.hayComidaColisionando()) {
            self.error("No hay nada para comer.")
        }
    }
}
 
//estados de snorlax
object snorlaxNormal {
    method nombre() { return "normal" }

    method animacion() {}

    method validarComer() {}
}

object snorlaxCapturado {
    var etapaTransicion = 0

    method nombre() { return "capturado-_" + etapaTransicion + "" }

    method animacion() {
        //Inicio animación
        snorlax.cambiarEstadoA(self)
        self.aplicarAnimacion()

        //Fin animación
        game.schedule(10000, {snorlax.cambiarEstadoA(snorlaxNormal) 
                              self.resetearTransicion()} )
        game.schedule(8000, {game.removeTickEvent("animacion")})
    }
    
    method aplicarAnimacion() { 
        game.onTick(500, "animacion", {self.realizarTransicion()}) 
    }

    method realizarTransicion() {
        etapaTransicion = (etapaTransicion + 1).min(14)
    }

    method resetearTransicion() {
        etapaTransicion = 0
    }

    method validarComer() {}
}

object snorlaxComiendo {
    method nombre() { return "come" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }

    method validarComer() {
        if (not self.hayCelda(abajo)) {
            self.error("No se puede cambiar de estado mientras snorlax come")
        }
    }

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }
}

object snorlaxRecibiendoDaño {
    method nombre() { return "daño-1" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(1000, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }

    method validarComer() {}
}

object snorlaxPerdedor {
    method nombre() { return "perdedor-1" }

    method animacion() {
        snorlax.cambiarEstadoA(snorlaxRecibiendoDaño)
        game.schedule(2000, {snorlax.cambiarEstadoA(self)})
    }

    method validarComer() {}
}


// Visualizador de vidas

object vida {
    var property position = game.at(4,9)

    method image() {
        return "icono-" + snorlax.vidas() + "-vidas.png"
    }
}

// puntuacion de snorlax

object puntuacion{
    var property puntos = 0
    var property position = game.at(1,10) 
    
    method incrementaPuntos(puntosFruta){
        puntos += puntosFruta
    } 

    method text() { return self.puntos().toString() }
}