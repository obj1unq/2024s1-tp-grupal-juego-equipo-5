import alimentosFrutales.*
import obstaculos.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// DETECTIVE
object pikachu {

	var property estado = caminando
	var property position = game.at(1, 1)
	var property tengoLlave = false // HAY UNA SOLA LLAVE POR NIVEL
	var property heRescatadoAlPrisionero = false // HAY UN SOLO PRISIONERO POR NIVEL
	var property energia = 100
	const escenario = tablero

	method estado(estadoACambiar) {
		if (estado != estadoACambiar) {
			estado = estadoACambiar
			estado.activar()
		}
	}

	method image() = estado.image()

	method text() = energia.toString()

	method textColor() = "FF00FF"

	method comerFruta(fruta) {
		energia += fruta.energia()
		self.siEstaAgotadoMuere()
	}

	method siEstaAgotadoMuere() {
		if (energia < 0) {
			self.estado(muerto)
		}
	}

	method mover(dir) {
		self.validarMover(dir)
		position = dir.siguiente(position)
		self.estado().aspecto(dir.toString())
	}

	method validarMover(dir) {
		if (not self.puedeMover(dir)) {
			self.error("No puedo ir a " + dir)
		}
	}

	method puedeMover(dir) {
		return estado.puedeMover() && escenario.puedeIr(self.position(), dir)
	}

	method obtenerLlave() {
		tengoLlave = true
	}

	method liberarPokemon() {
		heRescatadoAlPrisionero = true
	}

}

// ESTADOS DEL DETECTIVE
object caminando {

	var property aspecto = "derecha"

	method image() = "caminando-" + aspecto + ".png"

	method puedeMover() = true

	method activar() {
	}

}

object ganador {

	var property aspecto = ""

	method image() = "ganador.png"

	method puedeMover() = false

	method activar() {
		game.say(pikachu, "Lo logré!")
	}

}

object muerto {

	var property aspecto = ""

	method image() = "muerto.png"

	method puedeMover() = false

	method activar() {
		game.say(pikachu, "Perdí!")
		game.schedule(2000, { game.stop()})
	}

}

// POKEBOLA
object pokebola {

	var property position = game.at(16, 10)
	var property miPokemon = pikachu
	const property image = "pokebola.png"

	method esAtravesable() = miPokemon.heRescatadoAlPrisionero()

	method colision(pokemon) {
		pokemon.estado(ganador)
		game.schedule(1000, { game.removeVisual(self)})
	}

}

// LLAVE
object llave {

	var property position = game.at(3, 10)
	var property image = "llave.png"

	method esAtravesable() = true

	method colision(pokemon) {
		pokemon.obtenerLlave()
		game.removeVisual(self)
	}

}

// POKEMONS PRISIONEROS
class Prisionero {

	const property rescatador = pikachu

	method position()

	method image()

	method esAtravesable() = rescatador.tengoLlave()

	method colision(pokemon) {
		pokemon.liberarPokemon()
		self.liberar()
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self) })
	}

	method liberar()

}

class PrisioneroCharmander inherits Prisionero {

	var property position
	var property image = "preso-charmander.png"

	override method liberar() {
		image = "libre-charmander.png"
	}

}

class PrisioneroEvee inherits Prisionero {

	var property position
	var property image = "preso-evee.png"

	override method liberar() {
		image = "libre-evee.png"
	}

}

class PrisioneroPidgeot inherits Prisionero {

	var property position
	var property image = "preso-pidgeot.png"

	override method liberar() {
		image = "libre-pidgeot.png"
	}

}

class PrisioneroSquirtle inherits Prisionero {

	var property position
	var property image = "preso-squirtle.png"

	override method liberar() {
		image = "libre-squirtle.png"
	}

}

class PrisioneroVulpix inherits Prisionero {

	var property position
	var property image = "preso-vulpix.png"

	override method liberar() {
		image = "libre-vulpix.png"
	}

}

// PRISIONERO PARA EL NIVEL 1
object newSquirtle {
	
	method crear() {
		const squirtle = new PrisioneroSquirtle(position = game.at(3,3))
		game.addVisual(squirtle)
	}
	
}

// PRISIONERO PARA EL NIVEL 2
object newEvee {
	
	method crear() {
		const evee = new PrisioneroEvee(position = game.at(2,2))
		game.addVisual(evee)
	}
	
}

// PRISIONERO PARA EL NIVEL 3
object newPidgeot {
	
	method crear() {
		const pidgeot = new PrisioneroPidgeot(position = game.at(2,3))
		game.addVisual(pidgeot)
	}
	
}

// PRISIONERO PARA EL NIVEL 4
object newVulpix {
	
	method crear() {
		const vulpix = new PrisioneroVulpix(position = game.at(1,3))
		game.addVisual(vulpix)
	}
	
}

// PRISIONERO PARA EL NIVEL 5
object newCharmander {
	
	method crear() {
		const charmander = new PrisioneroCharmander(position = game.at(1,2))
		game.addVisual(charmander)
	}
	
}

