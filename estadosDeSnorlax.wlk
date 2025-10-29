import snorlax.*

object snorlaxNormal {
    method nombre() { return "normal" }

    method animacion() {}

    method validarAdormecimiento() {}
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

    method validarAdormecimiento() {}
}

object snorlaxComiendo {
    method nombre() { return "come" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }

    method validarAdormecimiento() {}

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }
}

object snorlaxRecibiendoDaño {
    method nombre() { return "daño" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(1000, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }

    method validarAdormecimiento() {}
}

object snorlaxPerdedor {
    method nombre() { return "perdedor" }

    method animacion() {
        snorlax.cambiarEstadoA(snorlaxRecibiendoDaño)
        game.schedule(1000, {snorlax.cambiarEstadoA(self)})
    }

    method validarAdormecimiento() {}
}


object snorlaxAdormecido {
    method nombre() { return "adormecido" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(8000, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }

    method validarAdormecimiento() {
        self.error("No puede comer mientras esta con sueño.")
    }
}