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