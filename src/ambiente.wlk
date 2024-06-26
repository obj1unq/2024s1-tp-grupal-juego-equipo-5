import pokemons.*
import config.*
import wollok.game.*

// PAREDES
class Pared inherits Articulo {

	override method image() = "pared.png"

}

object info {
	
	const property position = game.at(game.width() - 1, 0)
	
	method image() = "info.png"

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
	
	method image() = "icon-Pikachu-" + self.vitalidad(pikachu.energia()) + ".png"
	
	method vitalidad(energia) {
		return if (energia < 0) {
			"muerto"
		} else {
			"vivo"
		}
	}
	
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
class EstadoCorazon {

	method estaEnPorcentaje(energia) {
		return energia.between(self.inicio(), self.fin())
	}

	method inicio()

	method fin()

}

object vacio inherits EstadoCorazon {

	override method inicio() = -1000

	override method fin() = 0

}

object cuarto inherits EstadoCorazon {

	override method inicio() = 1

	override method fin() = 150

}

object medio inherits EstadoCorazon {

	override method inicio() = 151

	override method fin() = 300

}

object trescuartos inherits EstadoCorazon {

	override method inicio() = 301

	override method fin() = 450

}

object lleno inherits EstadoCorazon {

	override method inicio() = 451

	override method fin() = 600

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

object cofresManager {

	const cofres = []

	method agregarCofre(cofre) {
		cofres.add(cofre)
	}

	method colocarLLave() {
		const cofreConLLave = cofres.anyOne()
		cofreConLLave.contenido(llave)
	}

	method crearCofre(posicion) {
		const cofre = new Cofre(position = posicion)
		self.agregarCofre(cofre)
		game.addVisual(cofre)
	}
	
	method resetear() {
		cofres.clear()
	}

}

object llave {

	var property position
	const property sonido = "agarrarLlave.wav"

	method image() {
		return "llave.png"
	}

	method action() {
		game.say(pikachu, "Si!, la encontramos")
		self.cambiarVisual()
		pikachu.obtenerLlave()
		sonidosManager.sonar(self.sonido())
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

class Puerta {

	var property position
	var property estado

	method colision(pokemon) {
	}

	method action() {
	}

	method cambiarEstado() {
		estado = estado.siguiente()
	}

	method esAtravesable() = estado.esAtravesable()

	method image() = "puerta-" + self.estado().toString() + ".png"  

}

object cerrada {

	method esAtravesable() = false

	method siguiente() {
		return abierta
	}

}

object abierta {

	method esAtravesable() = true
	
	method siguiente() {
		return cerrada
	}

}

class Boton inherits Articulo {

	var property image = "botonSinPresion.png"
	var estaPresionado = false
	const property sonido = "musica-botonPuertas.wav"
	
	override method action() {
		puertasManager.cambiarEstadoPuertas()
		self.cambiarImagen()
		sonidosManager.sonar(self.sonido())
	}

	method cambiarImagen() {
		if (estaPresionado) {
			image = "botonSinPresion.png"
		} else {
			image = "botonConPresion.png"
		}
		estaPresionado = !estaPresionado
	}

}

object puertasManager {

	const puertas = []

	method cambiarEstadoPuertas() {
		puertas.forEach({ puerta => puerta.cambiarEstado()})
	}

	method agregarPuerta(puerta) {
		puertas.add(puerta)
	}

	method crearPuerta(estado, posicion) {
		const puerta = new Puerta(position = posicion, estado = estado)
		self.agregarPuerta(puerta)
		game.addVisual(puerta)
	}

}
