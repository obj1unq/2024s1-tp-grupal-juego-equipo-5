import alimentosFrutales.*
import enemigos.*
import pokemons.*
import posicionamiento.*
import randomizer.*
import transiciones.*
import wollok.game.*

// PAREDES
class Pared inherits Articulo {

	override method image() = "pared.png"

}

// BARRA DE ESTADO ACTUAL DE PIKACHU
object anotador {

	method generarVisuales() {
		game.addVisual(iconPikachu)
		game.addVisual(iconCorazonPikachu)
	}

	method guardarLlave(unaLlave) {
		game.addVisualIn(unaLlave, game.at(2, game.height() - 1))
	}

}

object iconPikachu {

	const property position = game.at(0, game.height() - 1)

	method image() = "icon-Pikachu.png"

}

object iconCorazonPikachu {

	const property position = game.at(1, game.height() - 1)
	const estados = #{ vacio, cuarto, medio, trescuartos, lleno }

	method image() = "corazon-" + self.estadoActualDelCorazon().toString() + ".png"

	method text() = pikachu.energia().toString()

	method estadoActualDelCorazon() {
		return estados.find({ estado => estado.estaEnPorcentaje(pikachu.energia()) })
	}

}

// ESTADOS DEL CORAZON DE PIKACHU
object vacio {

	method estaEnPorcentaje(energia) {
		return energia <= 0
	}

}

object cuarto {

	method estaEnPorcentaje(energia) {
		return energia.between(1, 150)
	}

}

object medio {

	method estaEnPorcentaje(energia) {
		return energia.between(151, 300)
	}

}

object trescuartos {

	method estaEnPorcentaje(energia) {
		return energia.between(301, 450)
	}

}

object lleno {

	method estaEnPorcentaje(energia) {
		return energia.between(451, 600)
	}

}

// AMBIENTACION SIN COLISIONES
class Articulo {

	const property position

	method esAtravesable() = false

	method image()

	method action() {
	}

}

// AMBIENTACION SIN COLISIONES PERO CON ACCION
class Cofre inherits Articulo {

	var property estaAbierto = false
	var property image = "cofre-cerrado.png"
	var property contenido = null

	method cambiarImagen() {
		if (estaAbierto) {
			image = "cofre-cerrado.png"
		} else {
			image = "cofre-abierto.png"
		}
		estaAbierto = !estaAbierto
	}

	override method action() {
		self.cambiarImagen()
		if (contenido != null) {
			game.addVisualIn(contenido, self.position())
			contenido = null
		}
	}

}

object llave {

	var property position

	method image() {
		return "llave.png"
	}

	method action() {
		game.say(pikachu, "Si!, la encontramos")
		self.cambiarVisual()
		pikachu.obtenerLlave()
	}

	method cambiarVisual() {
		self.ocultar()
		position = game.at(2, game.height() - 1)
		self.mostrar()
	}

	method mostrar() {
		game.addVisual(self)
	}

	method ocultar() {
		game.removeVisual(self)
	}

}

// ARREGLAR, HAY QUE MODIFICAR QUE SEA ATRAVESABLE PORQUE VA A TENER UN INTERRUMPOR
class Puerta inherits Articulo {

	method colision(pokemon) {
	}

	override method esAtravesable() = true

	override method image() = "puerta-abierta.png"

}

