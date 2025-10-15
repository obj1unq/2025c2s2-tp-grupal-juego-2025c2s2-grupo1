import personajes.*
import extras.*
import randomizer.*

//pokelitos
class Pokelito {
    const property gusto
    const property puntos = gusto.puntos()

    method nombre() { return "pokelito-" + gusto.nombre() }
}

class Frutilla {
    const property puntos = 150

    method nombre() { return "frutilla_" }
}

class Limon {
    const property puntos = 100

    method nombre() { return "limon_" }
}

class Naranja {
    const property puntos = 200

    method nombre() { return "naranja_" }
}

class DulceDeLeche {
    const property puntos = 250
    
    method nombre() { return "dulceDeLeche_" }
}

class Chocolate {
    const property puntos = 250

    method nombre() { return "chocolate_" }
}


object pokelitos {
    method nuevoPokelito(_gusto) { 
        return new Pokelito( gusto = _gusto)
    }

	method crearPokelito() {
		const pokelitoElegido = [
                {self.nuevoPokelito(new Frutilla())}, {self.nuevoPokelito(new Limon())},
                {self.nuevoPokelito(new Naranja())}, {self.nuevoPokelito(new DulceDeLeche())},
                {self.nuevoPokelito(new Chocolate())}].anyOne()

		return pokelitoElegido.apply()
	}
}
