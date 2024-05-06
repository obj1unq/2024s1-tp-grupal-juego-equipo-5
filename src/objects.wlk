import alimentosFrutales.*
import obstaculos.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

object pikachu {

	var property estado = caminando
	var property position = game.at(1, 1)
	var property tengoLlave = false
	var property heRescatadoAlPrisionero = false
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

object pokebola {

	var property position = game.at(16,10)
	var property miPokemon = pikachu
	const property image = "pokebola.png"
	
	method esAtravesable() = miPokemon.heRescatadoAlPrisionero()
	
	method colision(pokemon) {
		pokemon.estado(ganador)
		game.schedule(1000, { game.removeVisual(self) })
	}
}

object llave {
	var property position = game.at(3, 10)
	var property image = "llave.png"
	
	method esAtravesable() = true
	
	method colision(pokemon) {
		pokemon.obtenerLlave()
		game.removeVisual(self)
	}
}

// POKEMONS PRISIONEROS - REPETIMOS MUCHO CÓDIGO - REVEER class Prisionero? y después Herencia de distintos tipos de pokemons prisioneros?

object evee {
	
	const property rescatador = pikachu
	var property position = game.at(2,2)
	var property image = "preso-" + self.toString() + ".png"

	method esAtravesable() = rescatador.tengoLlave()

	method colision(pokemon) {
		pokemon.liberarPokemon()
		image = "libre-" + self.toString() + ".png"
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self) })
	}
}

object pidgeot {
	
	const property rescatador = pikachu
	var property position = game.at(2,3)
	var property image = "preso-" + self.toString() + ".png"

	method esAtravesable() = rescatador.tengoLlave()

	method colision(pokemon) {
		pokemon.liberarPokemon()
		image = "libre-" + self.toString() + ".png"
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self) })
	}
}

object charmander {
	
	const property rescatador = pikachu
	var property position = game.at(3,2)
	var property image = "preso-" + self.toString() + ".png"

	method esAtravesable() = rescatador.tengoLlave()

	method colision(pokemon) {
		pokemon.liberarPokemon()
		image = "libre-" + self.toString() + ".png"
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self) })
	}
}


// ESTADOS DE PIKACHU
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
		game.schedule(2000, { game.stop() })
	}
}

