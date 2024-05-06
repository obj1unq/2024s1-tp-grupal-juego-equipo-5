import alimentosFrutales.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// PAREDES
object paredFactory {

	const property paredes = #{}

	method crearPared(posicion) {
		const paredNueva = new Pared(position = posicion)
		paredes.add(paredNueva)
	}

	method agregarVisualParedes() {
		paredes.forEach({ pared => game.addVisual(pared)})
	}

	method levantarParedDe(longitud, posicionInicial, direccion) {
		var posicionActual = posicionInicial
		self.crearPared(posicionInicial)
		(longitud - 1).times{ indice =>
			posicionActual = direccion.siguiente(posicionActual)
			self.crearPared(posicionActual)
		}
	}

	method levantarBordes() {
		self.levantarParedDe(game.height() - 1, game.at(0, 0), arriba)
		self.levantarParedDe(game.height() - 1, game.at(game.width() - 1, 0), arriba)
		self.levantarParedDe(game.width(), game.at(1, game.height() - 2), derecha)
		self.levantarParedDe(game.width(), game.at(1, 0), derecha)
	}

}

class Pared {

	const property position

	method image() = "pared-normal.png"

	method esAtravesable() = false

}

object paredesDelNivel {

	method uno() {
		// INTERNAS
		paredFactory.levantarParedDe(4, game.at(10, 1), arriba)
		paredFactory.levantarParedDe(4, game.at(10, 7), arriba)
		paredFactory.levantarParedDe(3, game.at(5, 2), arriba)
		paredFactory.levantarParedDe(2, game.at(4, 9), arriba)
		paredFactory.levantarParedDe(14, game.at(2, 6), derecha)
		paredFactory.levantarParedDe(8, game.at(1, 4), derecha)
		paredFactory.levantarParedDe(5, game.at(12, 4), derecha)
		paredFactory.levantarParedDe(2, game.at(3, 8), derecha)
		paredFactory.levantarParedDe(1, game.at(1, 8), izquierda)
		// BORDES
		paredFactory.levantarBordes()
		// VISUALES
		paredFactory.agregarVisualParedes()
	}

	method dos() { // SIN TERMINAR
		// INTERNAS
		paredFactory.levantarParedDe(8, game.at(1, 5), derecha) 
		paredFactory.levantarParedDe(5, game.at(16, 5), izquierda)
		// BORDES
		paredFactory.levantarBordes()
		// VISUALES
		paredFactory.agregarVisualParedes()
	}

}

