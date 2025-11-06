import wollok.game.*

object randomizer {
		
	method position() {
		return 	game.at((0 .. game.width() - 4 ).anyOne(), 8) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}