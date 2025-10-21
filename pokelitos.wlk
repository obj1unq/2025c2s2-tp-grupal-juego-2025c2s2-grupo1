import personajes.*
import extras.*
import randomizer.*

//pokelitos
class Pokelito {
    const property gusto
    const property puntos = gusto.puntos()

    method nombre() { return "pokelito-" + gusto.nombre() }
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
        return new Pokelito( gusto = _gusto)
    }

	method crearPokelito() { return self.nuevoPokelito(self.gustoAlAzar()) }

    method gustoAlAzar() {
        return [frutilla, naranja, limon, dulceDeLeche, chocolate].anyOne()
    }
}
