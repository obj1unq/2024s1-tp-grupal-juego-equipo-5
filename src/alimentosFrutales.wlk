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

class Banana inherits Fruta{
	override method nombre() = "banana"
	override method energia() = 50
	override method mensaje(){
		return "Qué rico!"
	}
}

class Baya inherits Fruta{
	override method nombre() = "baya"
	override method energia() = -50
	override method mensaje(){
		return "Qué asco!"
	}
	
}

class Manzana inherits Fruta{
	override method nombre() = "manzana" 
	override method energia() = 80
	override method mensaje(){
		return "Qué sabroso!"
	}
}
class Fruta {
	var property position = randomizer.emptyPosition()
	
	method energia()
	method nombre()
	method image() = "f." + self.nombre() + ".png"
	method esAtravesable() = true
	method action(){}
	method mensaje()
	method colision(pokemon) {
		pokemon.comerFruta(self)
		game.say(pokemon, self.mensaje())
		frutaManager.frutas().remove(self)
		game.removeVisual(self)
	}
}
