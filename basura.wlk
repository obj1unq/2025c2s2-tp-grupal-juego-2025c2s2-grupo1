import snorlax.*
import fallingObjects.*
import randomizer.*
import factories.*
import estadosDeSnorlax.*
import sound.*

class Basura inherits FallingObject {
    //acciones
    override method chocasteConSnorlax() { 
        snorlax.validarEfecto(invulnerabilidad)
        basuraDelJuego.eliminarDelJuego(self)
        variante.aplicarEfecto()
    }

    override method eliminarDelJuegoEn(ticks) {
        game.schedule(ticks, {basuraDelJuego.eliminarDelJuego(self)})
    }

    override method nombre() { return variante.nombre() }
}

class VarianteBasura {
    const property nombre
    method aplicarEfecto() { snorlax.recibirDaño() }
}

class VarianteBasuraEspecial inherits VarianteBasura {
    const property estadoEspecial 
    const admiteSonido = false
    const sonidoEfecto = null

    override method aplicarEfecto() {
        estadoEspecial.animar()
        self.reproducirSonido()
    }

    method reproducirSonido() {
        if (admiteSonido) { gestorMusica.reproducirSonido(sonidoEfecto) }
    }
}

//Variantes de la basura
const bolsaDeBasura = new VarianteBasura(
    nombre = "bolsaDeBasura_"
)

const manzanaPodrida = new VarianteBasura(
    nombre = "manzana-podrida_"
)

const bota = new VarianteBasura(
    nombre = "bota_"
)

const pokebola = new VarianteBasuraEspecial (
    nombre = "pokebola_",
    estadoEspecial = snorlaxCapturado
) 

const pokeflauta = new VarianteBasuraEspecial (
    nombre = "pokeflauta_",
    estadoEspecial = snorlaxAdormecido,
    admiteSonido = true,
    sonidoEfecto = sleepSound
)
