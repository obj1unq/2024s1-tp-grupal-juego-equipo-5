import posicionamiento.*
import pokemons.*
import randomizer.*
import wollok.game.*

// ALIMENTOS FRUTALES DE PIKACHU
object frutaManager {

	const property frutas = []

	method nuevaFruta() {
		const fruta = [ bananaFactory, manzanaFactory, uvaFactory ].anyOne().nuevaFruta()
		if (frutas.size() < 8) {
			frutas.add(fruta)
			game.addVisual(fruta)
		}
	}

}

object bananaFactory {

	method nuevaFruta() {
		return new Banana()
	}

}

object manzanaFactory {

	method nuevaFruta() {
		return new Manzana()
	}

}

object uvaFactory {

	method nuevaFruta() {
		return new Uva()
	}

}

class Banana inherits Fruta {

	override method nombre() = "banana"

	override method energia() = 50

	override method mensaje() {
		return "Qué rico!"
	}

}

class Manzana inherits Fruta {

	override method nombre() = "manzana"

	override method energia() = 80

	override method mensaje() {
		return "Qué sabroso!"
	}

}

class Uva inherits Fruta {

	override method nombre() = "uva"

	override method energia() = -50

	override method mensaje() {
		return "Qué asco!"
	}

}

class Fruta {

	var property position = randomizer.emptyPosition()

	method action() {
	}

	method colision(pokemon) {
		pokemon.comerFruta(self)
		game.say(pokemon, self.mensaje())
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

	method energia()

	method esAtravesable() = true

	method image() = "fruta." + self.nombre() + ".png"

	method mensaje()

	method nombre()

}

