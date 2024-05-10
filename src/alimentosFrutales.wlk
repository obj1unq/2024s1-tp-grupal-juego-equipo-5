import posicionamiento.*
import objects.*
import randomizer.*
import wollok.game.*

// ALIMENTOS FRUTALES DE PIKACHU
object frutaManager {

	const property frutas = []

	method crearFruta() {
		if (frutas.size() < 8) {
			frutas.add([ bananaFactory, bayaFactory, bayaFactory, manzanaFactory].anyOne().crearFruta())
		}
	}

}

object bananaFactory {

	method crearFruta() {
		const banana = new Banana()
		game.addVisual(banana)
		return banana
	}

}

object bayaFactory {

	method crearFruta() {
		const baya = new Baya()
		game.addVisual(baya)
		return baya
	}

}

object manzanaFactory {

	method crearFruta() {
		const manzana = new Manzana()
		game.addVisual(manzana)
		return manzana
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

	method text() {
		return self.energia()
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

	method text() {
		return self.energia()
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

	method text() {
		return self.energia()
	}

}