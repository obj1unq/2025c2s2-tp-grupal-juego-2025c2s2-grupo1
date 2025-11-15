import snorlax.*

class EstadoBase {
    method nombre() { return "normal" }

    method animacion() {}

    method validarAdormecimiento() {}

    method estaInmovilizado() { return false }
}

const snorlaxNormal = new EstadoBase()

class EstadoSimple inherits EstadoBase {
    override method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(self.duracion(), {snorlax.cambiarEstadoA(snorlaxNormal)})
    }

    method duracion()
}

object snorlaxCapturado inherits EstadoBase {
    var etapaTransicion = 0

    override method nombre() { return "capturado-_" + etapaTransicion + "" }

    override method animacion() {
        //Inicio animación
        snorlax.cambiarEstadoA(self)
        self.aplicarAnimacion()

        self.resetearTransicion()

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

    override method estaInmovilizado() { return true }
}

object snorlaxComiendo inherits EstadoSimple {
    override method nombre() { return "come" }

    override method duracion() { return 500 }

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    } //revisar
}

object snorlaxRecibiendoDaño inherits EstadoSimple {
    override method nombre() { return "daño" }

    override method duracion() { return 1000 }
}

object snorlaxPerdedor inherits EstadoSimple {
    override method nombre() { return "perdedor" }

    override method duracion() { return 1000 }
}

object snorlaxAdormecido inherits EstadoSimple {
    override method nombre() { return "adormecido" }

    override method duracion() { return 8000 }

    override method validarAdormecimiento() {
        self.error("No puede comer mientras esta con sueño.")
    }
}

object snorlaxGanaNivel inherits EstadoSimple { 
    override method nombre() { return "gana" }

    override method duracion() { return 1000 }
}