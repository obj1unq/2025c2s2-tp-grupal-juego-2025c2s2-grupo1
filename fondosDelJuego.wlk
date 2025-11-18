class Fondo {
    method position() { return game.at(0, -1) } //Para evitar problemas con el whenCollideDo de Snorlax

    method image() { return "fondo-" + self.fondo() + ".png" }

    method fondo()
}

class FondoNivel inherits Fondo {
    const property nombreNivel

    override method fondo() { return "nivel-" + nombreNivel }
}

class FondoPantalla inherits Fondo {
    const property nombrePantalla

    override method fondo() { return "game-" + nombrePantalla }
}

//Fondos del juego
const fondoNivelFacil   = new FondoNivel( nombreNivel = "facil"   )
const fondoNivelNormal  = new FondoNivel( nombreNivel = "normal"  )
const fondoNivelDificil = new FondoNivel( nombreNivel = "dificil" )

const fondoDeInicio     = new FondoPantalla( nombrePantalla = "start" )
const fondoDeGameOver   = new FondoPantalla( nombrePantalla = "over"  )