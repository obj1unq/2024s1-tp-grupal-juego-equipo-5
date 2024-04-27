import posicionamiento.*
import objects.*
import randomizer.*
import wollok.game.*

// ALIMENTOS FRUTALES DE PIKACHU
object frutaManager {

	const property frutas = []

	method crearFruta() {
		if (frutas.size() < 6) {
			frutas.add([ ananaFactory, bayaFactory, platanoFactory ].anyOne().crearFruta())
		}
	}

}

object ananaFactory {

	method crearFruta() {
		const anana = new Anana()
		game.addVisual(anana)
		return anana
	}

}

object bayaFactory {

	method crearFruta() {
		const baya = new Baya()
		game.addVisual(baya)
		return baya
	}

}

object platanoFactory {

	method crearFruta() {
		const platano = new Platano()
		game.addVisual(platano)
		return platano
	}

}

class Anana {

	const property energia = 80
	const property image = "f.anana.png"
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

class Platano {

	const property energia = 50
	const property image = "f.platano.png"
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

