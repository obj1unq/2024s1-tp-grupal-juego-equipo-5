import config.*
import posicionamiento.*
import pokemons.*
import randomizer.*
import transiciones.*
import wollok.game.*

// ALIMENTOS FRUTALES DE PIKACHU
object frutaManager {

	const property frutas = []

	method nuevaFruta() {
		const fruta = [ bananaFactory, manzanaFactory, uvaFactory ].anyOne().nuevaFruta()
		if (self.puedeCrearNuevaFruta()) {
			frutas.add(fruta)
			game.addVisual(fruta)
		}
	}
	
	method puedeCrearNuevaFruta() {
		return self.condicionFrutas() and self.condicionInfo()
	}
	
	method configurarFrutas(){
		frutas.clear()
		self.iniciar()
	}
	
	method iniciar() {
		game.onTick(2000, "CREAR FRUTA", { self.nuevaFruta() })
	}

	method condicionInfo() {
		return not game.hasVisual(infoJugabilidad)
	}
	
	method condicionFrutas() {
		return frutas.size() < 8
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
	override method sonido() = "descVida.wav"
	
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
	
	method sonido() = "comer.mp3"
	
	method colision(pokemon) {
		sonidosManager.sonar(self.sonido())
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
