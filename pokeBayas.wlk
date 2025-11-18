import snorlax.*
import extras.*
import comida.*
import randomizer.*
import score.*
import variantesComida.*

class Baya inherits Comida {
    override method comer() {
        snorlax.ganarUnaVida()
        super()
    }

    method nombre() { return "baya-" + variante.nombre() }

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}

object bayalitas {
    method nuevoBayalita(_variante) { 
        return new Baya( variante = _variante, position = randomizer.emptyPosition() )
    }

	method crearBayalita() { return self.nuevoBayalita(self.varianteAlAzar()) }

    method varianteAlAzar() {
        return [varianteMeloc, varianteFrambu, varianteTamate, varianteZiuela, varianteGrana].anyOne()
    }
}