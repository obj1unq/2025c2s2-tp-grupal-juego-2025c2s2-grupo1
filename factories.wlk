import bolsaDeBasura.*
import pokeflauta.*
import pokebola.*
import bota.*
import manzanaPodrida.*
import randomizer.*
import pokelitos.*
import pokeBayas.*
import variantesComida.*

class Factory {
    const property itemsActivos = []

    method añadirAlAzar() {
        self.añadirAlJuego(self.crear())
    }

    method crear() {
        const itemElegido = self.todosLosItemsPosibles().anyOne()

        return itemElegido.apply()
    }

    method añadirAlJuego(item) {
        itemsActivos.add(item)
        game.addVisual(item)
    }

    method eliminarDelJuego(item) {
        itemsActivos.remove(item)
        game.removeVisual(item)
    }

    method removerTodo() {
        itemsActivos.forEach({item => self.eliminarDelJuego(item)})
    }

    method todosLosItemsPosibles()
}

object basuraDelJuego inherits Factory {
    method nuevaPokeflauta() {
        return new Pokeflauta( position = randomizer.emptyPosition() )
    }

    method nuevaPokebola() {
        return new Pokebola( position = randomizer.emptyPosition() )
    }

    method nuevaBota() {
        return new Bota( position = randomizer.emptyPosition() )
    }

    method nuevaBolsaDeBasura() {
        return new BolsaDeBasura( position = randomizer.emptyPosition() )
    }

    method nuevaManzanaPodrida() {
        return new ManzanaPodrida( position = randomizer.emptyPosition() )
    }

    override method todosLosItemsPosibles() {
        return [
            {self.nuevaPokeflauta()}, {self.nuevaPokebola()}, {self.nuevaBota()}, 
            {self.nuevaBolsaDeBasura()}, {self.nuevaManzanaPodrida()}
        ]
    }
}

object comidaDelJuego inherits Factory {
    override method todosLosItemsPosibles() {
        return [{pokelitos.crear()}, {bayalitas.crear()} ]
    }

    method hayComidaEn(_position) {
        return itemsActivos.any({comida => comida.position() == _position })
    }
}

class FactoryItems {
    method crear(_variante) 
    
    method variantes()

    method crear() { return self.crear(self.varianteAlAzar()) }

    method varianteAlAzar() { return self.variantes().anyOne() }
}

object pokelitos inherits FactoryItems {
    override method crear(_gusto) { 
        return new Pokelito( variante = _gusto, position = randomizer.emptyPosition() )
    }

	override method variantes() {
        return [frutilla, naranja, limon, dulceDeLeche, chocolate]
    }
}

object bayalitas inherits FactoryItems {
    override method crear(_variante) { 
        return new Baya( variante = _variante, position = randomizer.emptyPosition() )
    }

	override method variantes() {
        return [frambu, grana, tamate, ziuela, meloc]
    }
}