import posicionamiento.*
import objects.*
import randomizer.*
import wollok.game.*

// ALIMENTOS FRUTALES DE PIKACHU
object frutaManager {

	const property frutas = []

	method nuevaFruta() {
		const fruta = [ bananaFactory, bayaFactory, manzanaFactory].anyOne().nuevaFruta()
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

object bayaFactory {

	method nuevaFruta() {
		return new Baya()
	}

}

object manzanaFactory {

	method nuevaFruta() {
		return new Manzana()
	}

}

class Banana {

	const property energia = 50
	const property image = "f.banana.png"
	var property position = randomizer.emptyPosition()

	method esAtravesable() {
		return true
	}

	method colision(pokemon) {
		pokemon.comerFruta(self)
		game.say(pokemon, "Qué rico!")
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

}

class Baya {

	const property energia = -50
	const property image = "f.baya.png"
	var property position = randomizer.emptyPosition()

	method esAtravesable() {
		return true
	}

	method colision(pokemon) {
		pokemon.comerFruta(self)
		game.say(pokemon, "Qué asco!")
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

}

class Manzana {

	const property energia = 80
	const property image = "f.manzana.png"
	var property position = randomizer.emptyPosition()

	method esAtravesable() {
		return true
	}

	method colision(pokemon) {
		pokemon.comerFruta(self)
		game.say(pokemon, "Qué sabroso!")
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

}

