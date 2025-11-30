import randomizer.*
import basura.*
import comida.*
import comidaVariantes.*
import estadosDeSnorlax.*
import sound.*

//Gestores de las factories
class GestorFactory {
    const property itemsActivos = []

    //Acciones en los items activos
    method añadirAlJuego(item) {
        itemsActivos.add(item)
        game.addVisual(item)
    }

    method eliminarDelJuego(item) {
        itemsActivos.remove(item)
        game.removeVisual(item)
    }

    method removerTodo() { itemsActivos.forEach({ item => self.eliminarDelJuego(item) }) }

    //Creación de items al azar
    method crear() {
        const itemElegido = self.factories().anyOne()

        return itemElegido.apply()
    }

    method añadirAlAzar() { self.añadirAlJuego(self.crear()) }

    method factories()
}

object basuraDelJuego inherits GestorFactory {
    override method factories() { return [ {factoryBasuras.crear()} ] }
}

object comidaDelJuego inherits GestorFactory {
    override method factories() {
        return [{factoryPokelitos.crear()}, {factoryBayalitas.crear()} ]
    }

    method hayComidaEn(_position) {
        return itemsActivos.any({comida => comida.position() == _position })
    }
}

//Factories de los falling items
class FactoryItems {
    //Fabricación de items
    method crear(_variante) 
    
    method crear() { return self.crear(self.varianteAlAzar()) }

    //Sobre las variantes
    method variantes()

    method varianteAlAzar() { return self.variantes().anyOne() }
}

object factoryPokelitos inherits FactoryItems {
    override method crear(_gusto) { 
        return new Pokelito( variante = _gusto, position = randomizer.emptyPosition() )
    }

	override method variantes() {
        return [frutilla, naranja, limon, dulceDeLeche, chocolate]
    }
}

object factoryBayalitas inherits FactoryItems {
    override method crear(_variante) { 
        return new Baya( variante = _variante, position = randomizer.emptyPosition() )
    }

	override method variantes() {
        return [frambu, grana, tamate, ziuela, meloc]
    }
}

object factoryBasuras inherits FactoryItems {
    override method crear(_variante) { 
        return new Basura( variante = _variante, position = randomizer.emptyPosition() )
    }

	override method variantes() {
        return [bolsaDeBasura, manzanaPodrida, bota, pokebola, pokeflauta]
    }
}