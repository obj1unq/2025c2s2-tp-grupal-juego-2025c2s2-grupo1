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


object primerEstado {
    method nivel() { return 0 }
    method proximoEstado() { return segundoEstado }
}

object segundoEstado {
    method nivel() { return 1 }
    method proximoEstado() { return tercerEstado }
}

object tercerEstado {
    method nivel() { return 2 }
    method proximoEstado() { return cuartoEstado }
}

object cuartoEstado {
    method nivel() { return 3 }
    method proximoEstado() { return primerEstado }
}

object quintoEstado {
    method nivel() { return 4 }
    method proximoEstado() { return ultimoEstado }
}

object ultimoEstado {
    method nivel() { return 5 }
    method proximoEstado() { return self }
}