import posicionamiento.*
import objects.*
import randomizer.*
import wollok.game.*

// ALIMENTOS FRUTALES DE PIKACHU
object frutaManager {

	const property frutas = []

	method crearFruta() {
		if (frutas.size() < 6) {
			frutas.add([ manzanaFactory, bayaFactory, bananaFactory ].anyOne().crearFruta())
		}
	}

}

object manzanaFactory {

	method crearFruta() {
		const manzana = new Manzana()
		game.addVisual(manzana)
		return manzana
	}

}

object bayaFactory {

	method crearFruta() {
		const baya = new Baya()
		game.addVisual(baya)
		return baya
	}

}

object bananaFactory {

	method crearFruta() {
		const banana = new Banana()
		game.addVisual(banana)
		return banana
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
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

	method text() {
		return self.energia().toString()
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
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

	method text() {
		return self.energia().toString()
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
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}

	method text() {
		return self.energia().toString()
	}

}

