import alimentos.*
import posicionamiento.*
import pokemons.*
import transiciones.*
import menu.*
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
		keyboard.down().onPressDo({ pikachu.mover(abajo) })
		keyboard.up().onPressDo({ pikachu.mover(arriba) })
		keyboard.left().onPressDo({ pikachu.mover(izquierda) })
		keyboard.right().onPressDo({ pikachu.mover(derecha) })
		keyboard.p().onPressDo({ game.say(pikachu, "Pika, Pika, Pikachu") })
		keyboard.e().onPressDo({ pikachu.interactuarConObjeto() })
		keyboard.i().onPressDo({ infoJugabilidad.accionar() })
		//keyboard.m().onPressDo({ sonidosManager.subirVolumen() })
		//keyboard.n().onPressDo({ sonidosManager.bajarVolumen() })
		keyboard.s().onPressDo({ sonidosManager.silenciarVolumen() })
		keyboard.v().onPressDo({ sonidosManager.establecerVolumen() })
	}
	//CONFIG. TECLAS MENU
	method configurarTeclasMenu(){
		keyboard.down().onPressDo({cursor.mover(cursor.position().down(1))})
		keyboard.up().onPressDo({cursor.mover(cursor.position().up(1))})
		keyboard.enter().onPressDo({cursor.action()})
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
		self.establecerVolumen()
		sonidoFondo.shouldLoop(true)
		game.schedule(7, { sonidoFondo.play() })
	}
	
	method stop(){
		game.schedule(7, { sonidoFondo.stop() })
	}
	
	method subirVolumen() {
		// completar, el ejemplo del wollok doc no funciona
	}
	
	method bajarVolumen() {
		// completar, el ejemplo del wollok doc no funciona
	}
	
	method silenciarVolumen() {
		sonidoFondo.volume(0)
	}
	
	method establecerVolumen() {
		sonidoFondo.volume(0.15)
	}
	
}