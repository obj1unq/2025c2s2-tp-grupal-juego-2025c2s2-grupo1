import snorlax.*
import extras.*
import comida.*
import randomizer.*
import score.*

//pokelitos
class Pokelito inherits Comida {
    const property gusto
    const property puntos = gusto.puntos()

    override method comer() {
        super()
        puntuacion.incrementaPuntos(puntos)
    }

    method nombre() { return "pokelito-" + gusto.nombre() }

    override method image() { return self.nombre() + estado.nivel() + ".png" }
}

object frutilla {
    const property puntos = 150

    method nombre() { return "frutilla_" }
}

object limon {
    const property puntos = 100

    method nombre() { return "limon_" }
}

object naranja {
    const property puntos = 200

    method nombre() { return "naranja_" }
}

object dulceDeLeche {
    const property puntos = 250
    
    method nombre() { return "dulceDeLeche_" }
}

object chocolate {
    const property puntos = 250

    method nombre() { return "chocolate_" }
}


object pokelitos {
    method nuevoPokelito(_gusto) { 
        return new Pokelito( gusto = _gusto, position = randomizer.emptyPosition() )
    }

	method crearPokelito() { return self.nuevoPokelito(self.gustoAlAzar()) }

    method gustoAlAzar() {
        return [frutilla, naranja, limon, dulceDeLeche, chocolate].anyOne()
    }
}
