import snorlax.*
import extras.*
import comida.*
import randomizer.*

class Baya inherits Comida {
    const property gusto
    const property puntos = gusto.puntos()

    override method comer() { //No alterar la secuencia dado que puede generar Bug.
        snorlax.ganarUnaVida()
        super()
        puntuacion.incrementaPuntos(self.puntos())
    }

    method nombre() { return "baya-" + gusto.nombre() }

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}

object frambu {
    const property puntos = 500

    method nombre() { return "frambu_" }
}

object grana {
    const property puntos = 500

    method nombre() { return "grana_" }
}

object tamate {
    const property puntos = 500

    method nombre() { return "tamate_" }
}

object zieula {
    const property puntos = 500
    
    method nombre() { return "zieula_" }
}

object meloc {
    const property puntos = 500

    method nombre() { return "meloc_" }
}


object bayalitas {
    method nuevoBayalita(_gusto) { 
        return new Baya( gusto = _gusto, position = randomizer.emptyPosition() )
    }

	method crearBayalita() { return self.nuevoBayalita(self.gustoAlAzar()) }

    method gustoAlAzar() {
        return [meloc, frambu, tamate, zieula, grana].anyOne()
    }
}