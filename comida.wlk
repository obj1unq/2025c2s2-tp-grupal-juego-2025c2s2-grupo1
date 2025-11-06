import extras.*
import snorlax.*
import estadosDeSnorlax.*
import pokelitos.*
import randomizer.*
import fallingObjects.*
import pokeBayas.*

class Comida inherits FallingObject {
    //acciones
    method comer() {
        snorlaxComiendo.animacion()
        self.eliminarDelJuegoEn(500)
    }

    override method eliminarDelJuegoEn(ticks) {
         game.schedule(ticks, {comidaDelJuego.eliminarComidaDelJuego(self)})
    }

    override method chocasteConSnorlax() { 
        snorlax.levantarComida(self) 
    }
}

object comidaDelJuego {
    const property comidaActiva = []
	
    method nuevoPokelito() {
        return pokelitos.crearPokelito()
    }
    method nuevaBayalita(){
        return bayalitas.crearBayalita()
    }

	method crearComida() {
		const comidaElegida = [{self.nuevoPokelito()}, {self.nuevaBayalita()}].anyOne()

		return comidaElegida.apply()
	}

    method añadirComidaAlAzar() {
		self.añadirComidaAlJuego(self.crearComida())
	}
    
    method añadirComidaAlJuego(comida) {
        comidaActiva.add(comida)
        game.addVisual(comida)
    }

    method eliminarComidaDelJuego(comida) {
        comidaActiva.remove(comida)
        game.removeVisual(comida)
    }

    method removerTodo() {
        comidaActiva.forEach({comida => self.eliminarComidaDelJuego(comida)})
    }

    method hayComidaEn(_position) {
        return comidaActiva.any({comida => comida.position() == _position })
    }
}