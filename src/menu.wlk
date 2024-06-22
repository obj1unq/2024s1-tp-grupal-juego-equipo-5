import alimentos.*
import ambiente.*
import config.*
import enemigos.*
import pokemons.*
import posicionamiento.*
import transiciones.*
import wollok.game.*

object menu {

	const property optionMenu = [ start, tutorial, credits, exit ]

	method iniciarMenu() {
		game.clear()
		portadaManager.presentar(inicioDelJuego)
		config.teclasMenu()
		game.addVisual(cursor)
		self.setOptions(optionMenu)
	}

	method cleanOptions(options) {
		options.forEach({ option => game.removeVisual(option)})
	}

	method setOptions(options) {
		options.forEach({ option => game.addVisual(option)})
	}

}

object cursor {

	const property image = "cursor.png"
	var property position = game.at(6, 4)

	method mover(unaPosicion) {
		if (self.validacionDeMovimiento(unaPosicion)) {
			self.position(unaPosicion)
		}
	}

	method action() {
		self.option().forEach({ option => option.action()})
	// solo es 1, pero como es una coleccion, lo tratramos asi
	}

	method option() {
		return game.getObjectsIn(derecha.siguiente(self.position()))
	}

	method validacionDeMovimiento(unaPosicion) {
		return unaPosicion.x() == 6 and unaPosicion.y().between(2, 5)
	}

}

// OPCIONES MENU
class Option {

	method image() = "menu-" + self.toString() + ".png"

	method position() = game.at(7, self.positionX())

	method positionX()

}

object start inherits Option {

	override method positionX() = 5

	method action() {
		portadaManager.presentarNivel()
	}

}

object tutorial inherits Option {

	override method positionX() = 4

	method action() {
		game.clear()
		portadaManager.presentar(tutorialFondo)
		tutorialPuertas.iniciar() 
	}

}

object credits inherits Option {

	override method positionX() = 3

	method action() {
		game.clear()
		portadaManager.presentar(creditos)
		game.schedule(7000, { menu.iniciarMenu()})
	}

}

object exit inherits Option {

	override method positionX() = 2

	method action() {
		game.stop()
	}

}

class Tutorial {

	var vistos = 0
	
	method iniciar() {
		self.resetear()
		self.actualizar()
	}
	
	method actualizar() {
		if (self.quedanPorVer()) {
			self.mostrarActual()
			self.aumentarVistos()
			game.schedule(4000, { self.actualizar() })
		} else {
			self.ocultarElementos()
			self.continuar()
		}
	}
	
	method actual() {
		return self.elementos().get(vistos)
	}

	method aumentarVistos() {
		vistos += 1
	}

	method mostrarActual() {
		self.actual().mostrar()
	}

	method ocultarElementos() {
		self.elementos().forEach({ elemento => elemento.ocultar() })
	}
	
	method resetear() {
		vistos = 0
	}

	method quedanPorVer() {
		return vistos < self.elementos().size()
	}

	method elementos()
	
	method continuar()

}

object tutorialPuertas inherits Tutorial {

	override method elementos() = [ t1, t2, t3 ]
	
	override method continuar() {
	 	tutorialCofres.iniciar()
	}
	
}

object tutorialCofres inherits Tutorial {

	override method elementos() = [ t4, t5 ]

	override method continuar() {
		menu.iniciarMenu()
	}
	
}

class ElementoTutorial inherits Portada {

	override method nombre() = "tutorial-" + self.seccion() + self.num().toString()

	method seccion()

	method num()

	method position()

	method mostrar() {
		game.addVisual(self)
	}

	method ocultar() {
		game.removeVisual(self)
	}

}

class ElementoTutorialPuertas inherits ElementoTutorial {

	override method seccion() = "Puertas-"

}

class ElementoTutorialCofres inherits ElementoTutorial {

	override method seccion() = "Cofres-"

}

object t1 inherits ElementoTutorialPuertas {

	override method position() = game.at(3, 9)

	override method num() = 1

}

object t2 inherits ElementoTutorialPuertas {

	override method position() = game.at(10, 6)

	override method num() = 2

}

object t3 inherits ElementoTutorialPuertas {

	override method position() = game.at(3, 3)

	override method num() = 3

}

object t4 inherits ElementoTutorialCofres {

	override method position() = game.at(6, 8)

	override method num() = 1

}

object t5 inherits ElementoTutorialCofres {

	override method position() = game.at(6, 3)

	override method num() = 2

}

