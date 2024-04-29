import alimentosFrutales.*
import obstaculos.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

object pikachu {

	var property estado = caminando
	var property miPokebola = pokebola
	var property position = game.at(3, 5)
	const escenario = tablero
	var energia = 100

	method estado(estadoACambiar) {
		if (estado != estadoACambiar) {
			estado = estadoACambiar
			estado.activar()
		}
	}

	method image() = estado.image()

	method energia() = energia

	method text() = energia.toString()

	method textColor() = "FF00FF"

	method comerFruta(fruta) {
		energia = energia + fruta.energia()
	}

	method mover(dir) {
		self.validarMover(dir)
		position = dir.siguiente(position)
	}

	method validarMover(dir) {
		if (not self.puedeMover(dir)) {
			self.error("No puedo ir a " + dir)
		}
	}

	method puedeMover(dir) {
		return estado.puedeMover() && escenario.puedeIr(self.position(), dir)
	}

	method entrarAPokebola() {
		self.validarEstaConSuPokebola()
		miPokebola.cambiarEstado(self)
	}

	method validarEstaConSuPokebola() {
		if (not self.mismaPosicionQue(miPokebola)) {
			self.error("No está mi pokebola")
		}
	}

	method mismaPosicionQue(cosa) {
		return cosa.position() == self.position()
	}

}

object pokebola {

	var property position = game.at(10, 10)
	var property miPokemon = pikachu
	var estado = libre

	method cambiarEstado(pokemon) {
		estado = estado.siguiente()
	}

	method image() {
		return estado.image()
	}

	method colision(pokemon) {
		pokemon.estado(capturado)
	}

	method esAtravesable() {
		return true
	}

}

object llave {
	var property position = game.at(3, 10)
	var property image = "llave.png"

	method esAtravesable() = true

	method colision(pokemon) {
		game.removeVisual(self)
	}	
}

// POKEMONS PRISIONEROS POR NIVEL

// NIVEL 1
object evee {

	var property position = game.at(2, 4)
	var property image = "preso-evee.png"

	method esAtravesable() = true

	method colision(pokemon) {
		game.removeVisual(self)
	}

}

// NIVEL 2
object pidgeot {

	var property position = game.at(0, 4)
	var property image = "preso-pidgeot.png"

	method esAtravesable() = true

	method colision(pokemon) {
		game.removeVisual(self)
	}

}

// NIVEL 3
object charmander {

	var property position = game.at(2, 4)
	var property image = "preso-charmander.png"

	method esAtravesable() = true

	method colision(pokemon) {
		game.removeVisual(self)
	}

}


// ESTADOS DE PIKACHU
object capturado {

	method puedeMover() = false

	method image() = "capturado.png"

	method activar() {
		game.say(pikachu, "Me salvé!")
		game.removeVisual(pikachu)
	}

}

object buscando {

	method puedeMover() = true

	method image() = "buscando.png"

	method activar() {
	}

}

object caminando {

	method puedeMover() = true

	method image() = "caminando-der.png"

	method activar() {
	}

}

object feliz {

	method puedeMover() = true

	method image() = "feliz.png"

	method activar() {
	}

}

// ESTADOS DE POKEBOLA
object libre {

	const property image = "pokebola-libre.png"

	method siguiente() {
		return ocupada
	}

}

object ocupada {

	const property image = "pokebola-ocupada.png" // tamaño 120x50 cambiar?

	method siguiente() {
		return libre
	}

}

// ESTADOS DE POKEMON SECUNDARIOS
object pkLibre {

	method image(pokemon) = "libre-" + pokemon + ".png"

	method siguiente() {
		return pkPreso
	}

}

object pkPreso {

	method image(pokemon) = "preso-" + pokemon + ".png"

	method siguiente() {
		return pkLibre
	}

}

