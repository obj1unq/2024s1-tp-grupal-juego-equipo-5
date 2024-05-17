import alimentosFrutales.*
import objects.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// PAREDES
class Pared inherits Articulo {

	override method image() = "pared.png"

}

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

class MapaDeParedesDelNivel {
	
	method agregar()
	
}

object mapaDeParedesDelNivel1 inherits MapaDeParedesDelNivel {
	
	override method agregar() {
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
	
}

object mapaDeParedesDelNivel2 inherits MapaDeParedesDelNivel {
		
	override method agregar() {
		// INTERNAS
		paredFactory.levantarParedDe(6, game.at(5, 1), arriba)
        paredFactory.levantarParedDe(3, game.at(5, 8), arriba)
        paredFactory.levantarParedDe(1, game.at(10, 1), arriba)
        paredFactory.levantarParedDe(8, game.at(10, 10), abajo)
        paredFactory.levantarParedDe(7, game.at(2, 3), derecha)
        paredFactory.levantarParedDe(9, game.at(15, 6), izquierda)
		// BORDES
		paredFactory.levantarBordes()
		// VISUALES
		paredFactory.agregarVisualParedes()
	}
	
}

object mapaDeParedesDelNivel3 inherits MapaDeParedesDelNivel {
		
	override method agregar() {
		// INTERNAS
		paredFactory.levantarParedDe(8, game.at(1, 4), derecha)
        paredFactory.levantarParedDe(2, game.at(8, 3), abajo)
        paredFactory.levantarParedDe(4, game.at(3, 5), arriba)
        paredFactory.levantarParedDe(1, game.at(2, 8), abajo)
        paredFactory.levantarParedDe(4, game.at(3, 4), derecha)
        paredFactory.levantarParedDe(5, game.at(5, 10), abajo)
        paredFactory.levantarParedDe(5, game.at(7, 10), abajo)
        paredFactory.levantarParedDe(4, game.at(8, 10), derecha)
        paredFactory.levantarParedDe(4, game.at(10, 1), arriba)
        paredFactory.levantarParedDe(5, game.at(11, 4), arriba)
        paredFactory.levantarParedDe(4, game.at(12, 4), derecha)
        paredFactory.levantarParedDe(5, game.at(13, 10), abajo)
        paredFactory.levantarParedDe(2, game.at(15, 8), derecha)
        paredFactory.levantarParedDe(2, game.at(14, 1), arriba)
        // BORDES
		paredFactory.levantarBordes()
		// VISUALES
		paredFactory.agregarVisualParedes()
	}
	
}

object mapaDeParedesDelNivel4 inherits MapaDeParedesDelNivel {
		
	override method agregar() {
		// INTERNAS
		paredFactory.levantarParedDe(7, game.at(1, 2), derecha)
        paredFactory.levantarParedDe(3, game.at(5, 4), arriba)
        paredFactory.levantarParedDe(6, game.at(7, 9), abajo)
        paredFactory.levantarParedDe(2, game.at(8, 9), arriba)
        paredFactory.levantarParedDe(5, game.at(5, 7), izquierda)
        paredFactory.levantarParedDe(4, game.at(5, 9), izquierda)
        paredFactory.levantarParedDe(6, game.at(9, 7), abajo)
        paredFactory.levantarParedDe(4, game.at(10, 2), derecha)
        paredFactory.levantarParedDe(5, game.at(13, 3), arriba)
        paredFactory.levantarParedDe(6, game.at(11, 8), derecha)
        paredFactory.levantarParedDe(2, game.at(10, 9), derecha)
        paredFactory.levantarParedDe(1, game.at(13, 10), abajo)
        paredFactory.levantarParedDe(6, game.at(16, 1), arriba)
        paredFactory.levantarParedDe(1, game.at(15, 2), abajo)
		// BORDES
		paredFactory.levantarBordes()
		// VISUALES
		paredFactory.agregarVisualParedes()
	}
	
}

object mapaDeParedesDelNivel5 inherits MapaDeParedesDelNivel {
		
	override method agregar() {
		// INTERNAS
		paredFactory.levantarParedDe(2, game.at(1, 6), abajo)
		paredFactory.levantarParedDe(9, game.at(3, 1), arriba)
		paredFactory.levantarParedDe(6, game.at(4, 4), derecha)
		paredFactory.levantarParedDe(6, game.at(4, 8), derecha)
		paredFactory.levantarParedDe(6, game.at(10, 2), izquierda)
		paredFactory.levantarParedDe(4, game.at(10, 6), izquierda)
		paredFactory.levantarParedDe(6, game.at(10, 10), izquierda)
		paredFactory.levantarParedDe(9, game.at(11, 2), arriba)
		paredFactory.levantarParedDe(5, game.at(13, 1), arriba)
		paredFactory.levantarParedDe(5, game.at(13, 11), abajo)
		paredFactory.levantarParedDe(2, game.at(14, 3), derecha)
		paredFactory.levantarParedDe(2, game.at(15, 9), derecha)
		paredFactory.levantarParedDe(3, game.at(16, 5), arriba)
		// BORDES
		paredFactory.levantarBordes()
		// VISUALES
		paredFactory.agregarVisualParedes()
	}
	
}


// VISOR

object iconPikachu {
	
	const property position = game.at(0,12)
	
	method image () = "icon-Pikachu.png"
}

object iconCorazonPikachu {
	
	const property position = game.at(1,12)
	
	method image() = "corazon-" + self.promedioVidaPikachu() + ".png"
	
	method promedioVidaPikachu(){
		return if(pikachu.energia() > 450) {
			"lleno"
		}else if(pikachu.energia().between(301,450)) {
			"trescuartos"
		}else if(pikachu.energia().between(151,300)) {
			"medio"
		}else if(pikachu.energia() >= 1) {
			"cuarto"
		}else{"vacio"}
	}
	
}

object iconLlave {
	
	const property position = game.at(2,12)
	
	method image() = "llave.png"
	
	method mostrar(){
		game.addVisual(self)
	}
	
	method ocultar() {
		game.removeVisual(self)
	}
	
}

// AMBIENTACION 

class Articulo {
	
	const property position
	
	method esAtravesable() = false
	
	method image()
}

class Baniera inherits Articulo {
	
	override method image() = "baniera.png"

}

class Cama inherits Articulo {
	
	override method image() = "cama.png"

}

class Inodoro inherits Articulo {
	
	override method image() = "inodoro.png"

}

class Lavamanos inherits Articulo {
	
	override method image() = "lavamanos.png"

}
	
class Mesa inherits Articulo {
	
	override method image() = "mesa.png"

}

class Ropero inherits Articulo {
	
	override method image() = "ropero.png"

}

class Silla inherits Articulo {
	
	override method image() = "silla.png"

}

class Sillon inherits Articulo {
	
	override method image() = "sillon.png"

}

class Sofa inherits Articulo {
	
	override method image() = "sofa.png"

}

// AMBIENTACION CON COLISIONES
class Atravesable {
	
	var property position
	
	method colision(pokemon)
	
	method esAtravesable() = true
	
	method image()
	
}

class Cofre inherits Atravesable {
	
	var property image = "cofre-cerrado.png"
	
	method apertura() {
		image = "cofre-abierto.png"
	}
	
	override method colision(pokemon) {
		self.apertura()
	}
	
}

class CofreConLlave inherits Cofre {
	
	const llave = iconLlave
	
	override method colision(pokemon) {
		super(pokemon)
		pokemon.obtenerLlave(llave)
	}
	
}

class Puerta inherits Atravesable {	
	
	override method colision(pokemon) {}
	
	override method image() = "puerta.png"

}

class Trampa inherits Atravesable {
	
	method danio()
	
	override method image() = "trampa-"
	
}

class Pinche inherits Trampa {
	
	override method colision(pokemon) {
		pokemon.recibirDanio(self)
		game.removeVisual(self)
	}
	override method danio() = 50
	
	override method image() = super() + "pinches.png"
	
}

