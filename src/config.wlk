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
		sonidosManager.generarMusicaNivel(nivelManager.numeroDeNivel())
	}
}	

object sonidosManager {
	
	var sonidoFondo
	var estadoSonido = on
	
	method sonar(nombreSonido){
		const sonido = game.sound(nombreSonido) 
		self.actualizar(sonido)
		game.schedule(7, {sonido.play()} )
	}
	
	method generarMusicaNivel(nivel){
		sonidoFondo = game.sound("musica-nivel-" + nivel.toString() + ".mp3")
		self.actualizar(sonidoFondo)
		sonidoFondo.shouldLoop(true)
		game.schedule(7, {sonidoFondo.play()} )	
	}
	
	method stop(){
		game.schedule(7, {sonidoFondo.stop()} )
	}
	
	method cambiarEstado() {
		estadoSonido = estadoSonido.siguiente()
	}
	
	method validarCambiarEstado() {
		if (not self.puedeCambiarEstado()) {
			self.error("No puede cambiar al estado del sonido pedido")
		}
	}
	
	method puedeCambiarEstado() {
		return estadoSonido != estadoSonido.siguiente()
	}
	
	method actualizar(sonido) {
		sonido.volume(estadoSonido.volumen())
	}
	
	method position() = game.at(0,0)
	
	method image() = estadoSonido.image()
	
	method visualizar() {
		game.addVisual(self)
	}
	
}

// ESTADO DEL SONIDO

class EstadoSonido {
	
	method image() = "sound-" + self.toString() + ".png"
	
	method volumen()
	
	method siguiente()
	
}

object on inherits EstadoSonido {
	
	override method volumen() = 0.15
	
	override method siguiente() = off
	
}

object off inherits EstadoSonido {
	
	override method volumen() = 0
	
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

