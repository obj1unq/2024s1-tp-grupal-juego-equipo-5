import alimentosFrutales.*
import objects.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// PAREDES
class Pared {

	const property position

	method image() = "pared-normal.png"

	method esAtravesable() = false

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


////ANOTADOR

object iconPikachu {
	var property position = game.at(0, game.height()-1)
	method image () = "icon-Pikachu.png"
}

object anotadorManager {
	
	const property paredes = #{}
	
	method levantarAnotadorDe(longitud, posicionInicial, direccion) {
		var posicionActual = posicionInicial
		self.crearAnotador(posicionInicial)
		(longitud - 1).times{ indice =>
			posicionActual = direccion.siguiente(posicionActual)
			self.crearAnotador(posicionActual)
		}
	}
	
	method crearAnotador(posicion) {
		const anotadorNuevo = new FondoAnotador(position = posicion)
		paredes.add(anotadorNuevo)
	}	
	
	method agregarVisualFondos() {
		paredes.forEach({ fondo => game.addVisual(fondo)})
		game.addVisual(iconPikachu)
		game.addVisual(iconCorazonPikachu)
	}
	method guardarLlave(unaLlave) {
		game.addVisualIn(unaLlave, game.at(2,game.height()-1)) 
	}
}

object iconCorazonPikachu {
	var property position = game.at(1, game.height()-1)
	
	method image() = "corazon-"+self.promedioVidaPikachu()+".png"
	
	method promedioVidaPikachu(){
		return if(pikachu.energia()==100){
			"trescuartos"
		}else if(pikachu.energia().between(50,90)){
			"mitad"
		}else if(pikachu.energia().between(10,40)){
			"cuarto"
		}else if(pikachu.energia().equals(0)){
			"vacio"
		}else{"lleno"}
	}
}

class FondoAnotador inherits Pared {
	override method image() = "fondoNegro.png"
}

//CASA PARA NIVEL 1 deberia ir en obstaculos?
object cama {
	const property position = game.at(13, 1)
	method image() {return "cama.png"}
	method esAtravesable() {return false}
}
object baniera {
	const property position = game.at(7, 10)
	method image() {return "baniera.png"}
	method esAtravesable() {return false}
}
object inodoro {
	const property position = game.at(9, 8)
	method image() {return "inodoro.png"}
	method esAtravesable() {return false}
}
object lavamanos {
	const property position = game.at(5, 9)
	method image() {return "lavamanos.png"}
	method esAtravesable() {return false}
}
object ropero {
	const property position = game.at(14, 3)
	method image() {return "ropero.png"}
	method esAtravesable() {return false}
}
object mesa {
	const property position = game.at(6, 3)
	method image() {return "mesa.png"}
	method esAtravesable() {return false}
}
object silla {
	const property position = game.at(7, 3)
	method image() {return "silla.png"}
	method esAtravesable() {return false}
}
object sofa {
	const property position = game.at(13, 10)
	method image() {return "sofa.png"}
	method esAtravesable() {return false}
}
object sillon {
	const property position = game.at(11, 9)
	method image() {return "sillon.png"}
	method esAtravesable() {return false}
}