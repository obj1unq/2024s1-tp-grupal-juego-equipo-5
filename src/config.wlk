import alimentosFrutales.*
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
		
	}
	//CONFIG. TECLAS MENU
	method configurarTeclasMenu(){
		keyboard.down().onPressDo({cursor.mover(cursor.position().down(2))})
		keyboard.up().onPressDo({cursor.mover(cursor.position().up(2))})
		keyboard.enter().onPressDo({cursor.action()})
	}
	// CONFIG. COLISIONES
	method colisiones() {
		game.onCollideDo(pikachu, { objeto => objeto.colision(pikachu) })
	}
	// CONFIG. FRUTAS
	method frutas() {
//		frutaManager.frutas().clear()
//		game.onTick(2000, "CREAR FRUTA", { frutaManager.nuevaFruta() })
		frutaManager.configurarFrutas()
	}
	
}

object sonidosManager {
	
	var sonidoFondo 
	
	method sonar(musica){
		game.schedule(7, { game.sound(musica).play() })
	}
	
	method generarMusicaNivel(nivel){
		sonidoFondo = game.sound("musica-nivel-" + nivel + ".mp3")
		sonidoFondo.volume(0.15)
		sonidoFondo.shouldLoop(true)
		game.schedule(7, { sonidoFondo.play() })
	}
	
	method resetearMusica(){
		sonidoFondo.shouldLoop(false)
		game.schedule(7, { sonidoFondo.stop() })
	}
	method stopMusicFondo(){
		sonidoFondo.stop()
	}
	method playMusicFondo(){
		sonidoFondo.stop()
	}
}

