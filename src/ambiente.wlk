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

object nivelManager {

	const niveles = [mapaDeParedesDelNivel1, 
					mapaDeParedesDelNivel2, 
					mapaDeParedesDelNivel3,
					mapaDeParedesDelNivel4,
					mapaDeParedesDelNivel5]
	var nivelActual = 0

	method numeroDeNivel() = nivelActual+1

	method nivelActual() {
		return niveles.get(nivelActual)
	}

	method aumentarNivelActual() {
		self.validarQueExistenMasNiveles()
		nivelActual++
	}
	
	method validarQueExistenMasNiveles(){
		if(niveles.size()-1 < nivelActual){
			self.error("No existen más niveles")
		}
	}
	method quedanNiveles() = nivelActual < niveles.size()-1
	method reset() {
		nivelActual = 0
	}
	
	method generarNivel() {
		if (self.quedanNiveles()) {
			game.clear()
			self.nivelActual().agregar()
			/*mapa.generar(levelManager.nivelActual())
			self.agregarJugador()
			self.generarEnemigosYAumentarDificultad()
			hud.add()*/
		} else {
			self.victoria()
		}
	}
	method victoria() {
		game.clear()
		//game.addVisual(victoria)
	}

}

// VISOR
object anotador{
	method generarVisuales(){
		game.addVisual(iconPikachu)
		game.addVisual(iconCorazonPikachu)
	}
	method guardarLlave(unaLlave) {
		game.addVisualIn(unaLlave, game.at(2,game.height()-1)) 
	}
}
object iconPikachu {
	
	const property position = game.at(0,12)
	
	method image () = "icon-Pikachu.png"
}

object iconCorazonPikachu {
	
	const property position = game.at(1,12)
	const estados = #{vacio, cuarto, medio, trescuartos, lleno}
	
	method image() = "corazon-" + self.estadoActualDelCorazon().porcentaje() + ".png"
	
	method text() = pikachu.energia().toString()
	
	method estadoActualDelCorazon(){
		return estados.find({estado => estado.estaEnPorcentaje(pikachu.energia())})
	}
	
}

// ESTADOS DEL CORAZON

object vacio{
	method estaEnPorcentaje(energia) = 0
	method porcentaje()="vacio"
}
object cuarto{
	method estaEnPorcentaje(energia) = energia.between(1, 150)
	method porcentaje()="cuarto"
}
object medio{
	method estaEnPorcentaje(energia) = energia.between(151, 300)
	method porcentaje()="medio"
}
object trescuartos{
	method estaEnPorcentaje(energia) = energia.between(301, 450)
	method porcentaje()="trescuartos"
}
object lleno{
	method estaEnPorcentaje(energia) = energia.between(451, 600)
	method porcentaje()="lleno"
}



// AMBIENTACION 

class Articulo {
	
	const property position
	
	method esAtravesable() = false
	
	method image()
	method action(){}
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

class Cofre inherits Articulo {
	
	var property estaAbierto = false
	var property image = "cofre-cerrado.png"
	var property contenido = null
	
	method cambiarImagen(){
		if (estaAbierto) {
			image = "cofre-cerrado.png"
		} else {
			image =  "cofre-abierto.png"			
		}
		estaAbierto = !estaAbierto
	}
	
	override method action() {
		self.cambiarImagen()
		if ( contenido != null){
			game.addVisualIn(contenido,self.position())
			contenido = null
		}
	}
	
}
object llave {
	var property position
	method image(){
		return "llave.png"
	}
	method colision(){}
	method action(){
		game.say(pikachu,"Si!, ayudemos a nuestro amigo")
		self.cambiarVisual()
		pikachu.obtenerLlave()
	}
	method cambiarVisual(){
		self.ocultar()
		position = game.at(2,12)
		self.mostrar()
	}
	method mostrar(){
		game.addVisual(self)
	}
	method ocultar(){
		game.removeVisual(self)
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

