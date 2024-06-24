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
	method sonidos(nivel) {
		sonidosManager.generarMusica(nivel)
	}
}	

object sonidosManager {
	
	var musica
	var estado = on 
	
	method generarMusica(nivel){	// OBS: generarMusicaSiPuede, sería un nombre más apropiado.
		if (self.estaEncendido()) {
			musica = game.sound("musica-nivel-" + nivel.toString() + ".mp3")
			musica.volume(0.15)
			musica.shouldLoop(true)
			musica.play()
		}
		
	}
	
	method sonar(sonido){			// OBS: sonarSiPuede, sería un nombre más apropiado.
		if (self.estaEncendido()) {
			game.sound(sonido).play()
		} 
		
	}
	
	method stop(){					// OBS: stopSiPuede, sería el nombre más apropiado.
		if (self.estaEncendido()) {
			musica.stop()
		}
		 
	}
	
	method estaEncendido(){
		return estado != off
	}
	
	method cambiarEstado() {
		self.validarCambiarEstado()
		estado = estado.siguiente()
	}
	
	method validarCambiarEstado() {
		if (not self.puedeCambiarEstado()) {
			self.error("No puede cambiar al estado del sonido pedido")
		}
	}
	
	method puedeCambiarEstado() {
		return estado != estado.siguiente()
	}
	
	method position() = game.at(0,0)
	
	method image() = estado.image()
	
	method visualizar() {
		game.addVisual(self)
	}
	
}

// ESTADO DEL SONIDO

class EstadoSonido {
	
	method image() = "sound-" + self.toString() + ".png"
	
	method siguiente()
	
}

object on inherits EstadoSonido {
	
	override method siguiente() = off
	
}

object off inherits EstadoSonido {
	
	override method siguiente() = on
	
}

// TECLADO

class Teclado {
	
	method usar()
	
}


object tecladoNiveles inherits Teclado {
	
	override method usar() {
		keyboard.down().onPressDo({ pikachu.mover(abajo) })
		keyboard.up().onPressDo({ pikachu.mover(arriba) })
		keyboard.left().onPressDo({ pikachu.mover(izquierda) })
		keyboard.right().onPressDo({ pikachu.mover(derecha) })
		keyboard.p().onPressDo({ pikachu.hablar() })
		keyboard.e().onPressDo({ pikachu.interactuarConObjeto() })
		keyboard.i().onPressDo({ infoJugabilidad.accionar() })
	}
	
}

object tecladoMenu inherits Teclado {
	
	override method usar() {
		keyboard.down().onPressDo({ cursor.mover(cursor.position().down(1)) })
		keyboard.up().onPressDo({ cursor.mover(cursor.position().up(1)) })
		keyboard.enter().onPressDo({ cursor.action() })
		keyboard.s().onPressDo({ sonidosManager.cambiarEstado() })
	}
	
}

