import alimentos.*
import menu.*
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
	// CONFIG. DE TECLAS: PIKACHU Y NIVEL
	method teclas() {
		tecladoNiveles.usar()
	}
	//CONFIG. DE TECLAS: MENU
	method teclasMenu() {
		tecladoMenu.usar()
	}
	// CONFIG. COLISIONES
	method colisiones() {
		game.onCollideDo(pikachu, { objeto => objeto.colision(pikachu) })
	}
	// CONFIG. FRUTAS
	method frutas() {
		frutaManager.configurarFrutas()
	}
	// CONFIG. SONIDOS
	method sonidos() {
		sonidosManager.generarMusicaNivel(nivelManager.numeroDeNivel().toString())
	}
}	

object sonidosManager {
	
	var sonidoFondo
	
	method sonar(musica){
		game.schedule(7, { game.sound(musica).play() })
	}
	
	method generarMusicaNivel(nivel){
		sonidoFondo = game.sound("musica-nivel-" + nivel + ".mp3")
		self.on()
		sonidoFondo.shouldLoop(true)
		game.schedule(7, { sonidoFondo.play() })
	}
	
	method stop(){
		game.schedule(7, { sonidoFondo.stop() })
	}
	
	method off() {
		sonidoFondo.volume(0)
	}
	
	method on() {
		sonidoFondo.volume(0.15)
	}
}
class Teclado {
	
	method usar() {
		keyboard.s().onPressDo({ sonidosManager.off() })
		keyboard.v().onPressDo({ sonidosManager.on() })
	}
	
}


object tecladoNiveles inherits Teclado {
	
	override method usar() {
		super()
		keyboard.down().onPressDo({ pikachu.mover(abajo) })
		keyboard.up().onPressDo({ pikachu.mover(arriba) })
		keyboard.left().onPressDo({ pikachu.mover(izquierda) })
		keyboard.right().onPressDo({ pikachu.mover(derecha) })
		keyboard.p().onPressDo({ 
			sonidosManager.sonar("pikachu.mp3")
			game.say(pikachu, "Pika, Pika, Pikachu")
		})
		keyboard.e().onPressDo({ pikachu.interactuarConObjeto() })
		keyboard.i().onPressDo({ infoJugabilidad.accionar() })
	}
	
}

object tecladoMenu inherits Teclado {
	
	override method usar() {
		super()
		keyboard.down().onPressDo({ cursor.mover(cursor.position().down(1)) })
		keyboard.up().onPressDo({ cursor.mover(cursor.position().up(1)) })
		keyboard.enter().onPressDo({ cursor.action() })
	}
	
}
