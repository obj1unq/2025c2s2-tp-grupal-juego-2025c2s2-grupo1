import personajes.*
import extras.*
import randomizer.*

//pokelitos
class Pokelito {
    const property gusto
    var estado = gusto.estado() 
    const property puntos = gusto.puntos()

    method estado() { return estado }
}

class Frutilla {
    var faseActual = 1
    const property puntos = 150

    method estado() { return "frutilla-" + faseActual + ".png" }
}

class Limon {
    var faseActual = 1
    const property puntos = 100

    method estado() { return "limon-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}

class Naranja {
    var faseActual = 1
    const property puntos = 200

    method estado() { return "naranja-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}

class DulceDeLeche {
    var faseActual = 1
    const property puntos = 250

    method estado() { return "dulceDeLeche-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
}

class Chocolate {
    var faseActual = 1
    const property puntos = 250

    method estado() { return "chocolate-" + faseActual + ".png" }

    method faseActual(fase) { faseActual = fase }
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
