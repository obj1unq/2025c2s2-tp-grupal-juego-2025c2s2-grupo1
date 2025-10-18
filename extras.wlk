import personajes.*

//direcciones de movimiento
object izquierda {
    method siguiente(personaje){
        return personaje.position().left(1)
    } 
}
object derecha {
    method siguiente(personaje){
      return personaje.position().right(1)
    }
} 

object arriba {
    method siguiente(personaje){
      return personaje.position().up(1)
    } 
} 

object abajo {
    method siguiente(personaje){
      return personaje.position().down(1)
    }
} 

//estados de los objetos cayendo
object primerEstado {
    method nivel() { return 0 }
    method proximoEstado(algo) {
        self.validarSnorlaxLevanta(algo)
        algo.estado(segundoEstado)
    }

    method validarSnorlaxLevanta(algo) {
        if (self.algoColisionaConSnorlax(algo)) {
            self.error("No puedo cambiar mientras snorlax me levanta")
        }
    }

    method algoColisionaConSnorlax(algo) {
        return algo.position() == snorlax.position()
    }
}

object segundoEstado {
    method nivel() { return 1 }
    method proximoEstado(algo) { 
        if (algo.hayCelda(abajo)) {// no puedo cortar el flujo con un error.
            algo.estado(tercerEstado)
        }
        else { algo.estado(quintoEstado) }
    }
}

object tercerEstado {
    method nivel() { return 2 }
    method proximoEstado(algo) { algo.estado(cuartoEstado) }
}

object cuartoEstado {
    method nivel() { return 3 }
    method proximoEstado(algo) { algo.estado(primerEstado) }
}

object quintoEstado {
    method nivel() { return 4 }
    method proximoEstado(algo) { algo.estado(ultimoEstado) }
}

object ultimoEstado {
    method nivel() { return 5 }
    method proximoEstado(algo) { 
        return self
    } //no cambia al llegar a este estado pues esta en el suelo.
}