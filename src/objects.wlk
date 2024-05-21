import alimentosFrutales.*
import ambiente.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// DETECTIVE
object pikachu {

	var property estado = caminando
	var property direccion = derecha
	var property position = game.at(1, 1)
	var property heRescatadoAlPrisionero = false // HAY UN SOLO PRISIONERO POR NIVEL
	var property energia = 100
	var property tieneLlave = false // HAY UNA SOLA LLAVE POR NIVEL
	const escenario = tablero

	method estado(estadoACambiar) {
		if (estado != estadoACambiar) {
			estado = estadoACambiar
			estado.activar()
		}
	}

	method image() = estado.image()

	// method text() = energia.toString()
	method textColor() = "FF00FF"

	method comerFruta(fruta) {
		energia = (energia + fruta.energia()).min(600)
		self.siEstaAgotadoMuere()
	}

	method siEstaAgotadoMuere() {
		if (energia < 0) {
			self.estado(muerto)
		}
	}

	method recibirDanio(enemigo) {
		energia -= enemigo.danio()
		game.say(self, "Ay! me dolió")
		self.siEstaAgotadoMuere()
	}

	method mover(dir) {
		if (self.puedeMover(dir)) {
			position = dir.siguiente(position) 
		}
		self.estado().aspecto(dir.toString())
	}

	method puedeMover(dir) {
		return estado.puedeMover() && escenario.puedeIr(self.position(), dir)
	}

	method obtenerLlave() {
		tieneLlave = true
	}

	method liberarPokemon() {
		heRescatadoAlPrisionero = true
		tieneLlave = false
	}

	method esAtravesable() = true

	method interactuarConObjeto() {
		const posiciones = #{
        direccion.siguiente(self.position()), direccion.opuesto().siguiente(self.position()), 
       	direccion.anterior().siguiente(self.position()),
       	direccion.siguiente().siguiente(self.position()) }
    
    	const objetos = posiciones.flatMap({pos => game.getObjectsIn(pos)})	
		
		if (objetos.isEmpty()) {
			self.error("Aqui no hay nada")
		}
		objetos.forEach({objeto=>objeto.action()})
		 
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
		game.schedule(3000, { game.stop()})
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
		game.schedule(500, { game.removeVisual(self)})
	}

}

// POKEMONS PRISIONEROS
class Prisionero {

	const property rescatador = pikachu

	method position()

	method image()

	method esAtravesable() = rescatador.tieneLlave()

	method colision(pokemon) {
		pokemon.liberarPokemon()
		self.liberar()
		llave.ocultar()
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self)})
	}

	method liberar()
	method action(){}
}

// PRISIONERO: NIVEL 1
object prisioneroEvee inherits Prisionero {

	const property position = game.at(2, 2)
	var property image = "preso-evee.png"

	override method liberar() {
		image = "libre-evee.png"
	}

}

// PRISIONERO: NIVEL 2
object prisioneroPidgeot inherits Prisionero {

	const property position = game.at(6, 4)
	var property image = "preso-pidgeot.png"

	override method liberar() {
		image = "libre-pidgeot.png"
	}

}

// PRISIONERO: NIVEL 3
object prisioneroVulpix inherits Prisionero {

	const property position = game.at(11, 1)
	var property image = "preso-vulpix.png"

	override method liberar() {
		image = "libre-vulpix.png"
	}

}

// PRISIONERO: NIVEL 4
object prisioneroSquirtle inherits Prisionero {

	const property position = game.at(16, 7)
	var property image = "preso-squirtle.png"

	override method liberar() {
		image = "libre-squirtle.png"
	}

}

// PRISIONERO: NIVEL 5
object prisioneroCharmander inherits Prisionero {

	const property position = game.at(4, 5)
	var property image = "preso-charmander.png"

	override method liberar() {
		image = "libre-charmander.png"
	}

}

