import alimentosFrutales.*
import posicionamiento.*
import objects.*
import wollok.game.*

object config {
	// CONFIG. DIMENSIONES DEL ESCENARIO
	method dimensiones() {
		game.cellSize(50)
		game.width(18)
		game.height(12)
	}
	// CONFIG. DE TECLAS DE PIKACHU
	method teclas() {
		keyboard.down().onPressDo({ pikachu.mover(abajo)})
		keyboard.up().onPressDo({ pikachu.mover(arriba)})
		keyboard.left().onPressDo({ pikachu.mover(izquierda)})
		keyboard.right().onPressDo({ pikachu.mover(derecha)})
		keyboard.enter().onPressDo({ game.say(pikachu, "Pika, Pika, Pikachu")})
		keyboard.s().onPressDo({ pikachu.entrarAPokebola()})
	}

}

