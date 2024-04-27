import alimentosFrutales.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// OBSTACULOS

object paredFactory {
	const property paredes = #{}
	
	method crearPared(posicion) {
		const parednueva = new Pared(position = posicion)
		game.addVisual(parednueva)
	}
	
	method agregarVisualParedes() {
		paredes.forEach({ pared => game.addVisual(pared) })
	}
	
	method levantarParedDe(longitud, posicionInicial, direccion) {
		var posicionActual = posicionInicial
		self.crearPared(posicionInicial)
		(longitud - 1).times{
			indice =>
				posicionActual = direccion.siguiente(posicionActual)
				self.crearPared(posicionActual)
		}
	}
	
	method levantarBordes() {
		self.levantarParedDe(game.height(), game.at(0,0)               , arriba)
		self.levantarParedDe(game.height(), game.at(game.width() -1 ,0), arriba)
		self.levantarParedDe(game.width(),  game.at(1,game.height() -1), derecha)
		self.levantarParedDe(game.width(),  game.at(1,0)               , derecha)
	}
}

class Pared {
	const property position
	
	method image() = "pared.jpg"

	method esAtravesable() = false

}
