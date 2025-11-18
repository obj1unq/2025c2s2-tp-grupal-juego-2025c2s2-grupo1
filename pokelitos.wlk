import snorlax.*
import extras.*
import comida.*
import randomizer.*
import score.*
import variantesComida.*

//pokelitos
class Pokelito inherits Comida {

    method nombre() { return "pokelito-" + variante.nombre() }

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}

object pokelitos {
    method nuevoPokelito(_gusto) { 
        return new Pokelito( variante = _gusto, position = randomizer.emptyPosition() )
    }

	method crearPokelito() { return self.nuevoPokelito(self.gustoAlAzar()) }

    method gustoAlAzar() {
        return [gustoFrutilla, gustoNaranja, gustoLimon, gustoDulceDeLeche, gustoChocolate].anyOne()
    }
}
