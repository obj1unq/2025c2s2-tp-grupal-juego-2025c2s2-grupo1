class Fondo {
    method position() { return game.at(0, -1) } //Para evitar problemas con el whenCollideDo de Snorlax

    method image() { return "fondo-" + self.fondo() + ".png" }

    method fondo()
}

class FondoNivel inherits Fondo {
    override method fondo() { return "nivel-" + self.nivel() }

    method nivel() //provisional facil
}

class FondoPantalla inherits Fondo {
    override method fondo() { return "game-" + self.pantalla() }

    method pantalla()
}

object fondoDeInicio inherits FondoPantalla {
    override method pantalla() { return "start" }
}

object fondoDeGameOver inherits FondoPantalla {
    override method pantalla() { return "over" }
}

object fondoNivelFacil inherits FondoNivel {
    override method nivel() { return "facil" }
}

object fondoNivelNormal inherits FondoNivel {
    override method nivel() { return "normal" }
}

object fondoNivelDificil inherits FondoNivel {
    override method nivel() { return "dificil" }
}