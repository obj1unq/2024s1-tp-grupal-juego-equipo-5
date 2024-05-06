import alimentosFrutales.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// PAREDES

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
		self.levantarParedDe(game.height() -1, game.at(0,0)               , arriba)
		self.levantarParedDe(game.height() -1, game.at(game.width() -1 ,0), arriba)
		self.levantarParedDe(game.width()    , game.at(1,game.height() -2), derecha)
		self.levantarParedDe(game.width()    , game.at(1,0)               , derecha)
	}
}

class Pared {
	const property position
	
	method image() = "pared-normal.png"

	method esAtravesable() = false

}

object paredes {
	method nivel1() {
		// INTERNAS
		paredFactory.levantarParedDe( 4, game.at(10,1), arriba )
		paredFactory.levantarParedDe( 4, game.at(10,7), arriba )
		paredFactory.levantarParedDe( 3, game.at(5,2) , arriba )
		paredFactory.levantarParedDe(14, game.at(2,6) , derecha)
		paredFactory.levantarParedDe( 8, game.at(1,4) , derecha)
		// BORDES
		paredFactory.levantarBordes()
	}
}

