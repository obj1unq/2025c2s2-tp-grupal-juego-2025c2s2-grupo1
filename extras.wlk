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
        algo.cambiarEstadoA(segundoEstado)
    }
}

object segundoEstado {
    method nivel() { return 1 }
    method proximoEstado(algo) {
        algo.cambiarEstadoA(tercerEstado)
    } 
}

object tercerEstado {
    method nivel() { return 2 }
    method proximoEstado(algo) { algo.cambiarEstadoA(cuartoEstado) }
}

object cuartoEstado {
    method nivel() { return 3 }
    method proximoEstado(algo) { algo.cambiarEstadoA(primerEstado) }
}