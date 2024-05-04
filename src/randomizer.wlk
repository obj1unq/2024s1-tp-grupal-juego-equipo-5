import wollok.game.*

object randomizer {
		
	method position() {
		return 	game.at( 
					(1 .. game.width()  - 1).anyOne(),
					(1 .. game.height() - 2).anyOne()
		) 
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