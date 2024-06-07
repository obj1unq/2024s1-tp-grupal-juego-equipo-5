import alimentosFrutales.*
import posicionamiento.*
import pokemons.*
import transiciones.*
import wollok.game.*

object config {
	// CONFIG. AMBIENTE BÁSICO: DIMENSIONES Y PISO DEL ESCENARIO
	method ambienteBasico() {
		game.cellSize(50)
		game.width(18)
		game.height(13)
		game.ground("piso.png")
	}
	// CONFIG. DE TECLAS DE PIKACHU
	method teclas() {
		keyboard.down().onPressDo({ pikachu.mover(abajo)})
		keyboard.up().onPressDo({ pikachu.mover(arriba)})
		keyboard.left().onPressDo({ pikachu.mover(izquierda)})
		keyboard.right().onPressDo({ pikachu.mover(derecha)})
		keyboard.p().onPressDo({ game.say(pikachu, "Pika, Pika, Pikachu")})
		keyboard.e().onPressDo({ pikachu.interactuarConObjeto()})
		keyboard.r().onPressDo({ gameManager.reset()})
		keyboard.i().onPressDo({ info.mostrarInfo()})
	}
	// CONFIG. COLISIONES
	method colisiones() {
		game.onCollideDo(pikachu, { objeto => objeto.colision(pikachu) })
	}
	// CONFIG. FRUTAS
	method frutas() {
		frutaManager.frutas().clear()
		game.onTick(2000, "CREAR FRUTA", { frutaManager.nuevaFruta() })
	}
	
}

