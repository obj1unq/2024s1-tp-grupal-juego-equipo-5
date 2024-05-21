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

class EstadoDetective {
	
	var property aspecto = ""
	
	method activar() {}
	
	method image()
	
	method puedeMover() = false
	
}
object caminando inherits EstadoDetective {

	override method aspecto() = "derecha"

	override method image() = "caminando-" + self.aspecto() + ".png"

	override method puedeMover() = true

}

object ganador inherits EstadoDetective {
	
	override method activar() {
		game.say(pikachu, "Lo logré!")
	}
	
	override method image() = "ganador.png"

}

object muerto inherits EstadoDetective {

	override method activar() {
		game.say(pikachu, "Perdí!")
		game.schedule(3000, {game.stop()})
	}
	
	override method image() = "muerto.png"

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
	var property preso = true
	
	method action(){}

	method colision(pokemon) {
		pokemon.liberarPokemon()
		self.liberar()
		llave.ocultar()
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self)})
	}
	
	method esAtravesable() = rescatador.tieneLlave()
	
	method image() {
		return if (not self.preso()) {
			"libre-" + self.nombre() + ".png"
		} else {
			"preso-" + self.nombre() + ".png"
		}
	}  

	method liberar() {
		preso = false
	}
	
	method nombre()
	
	method position()
	
}

// PRISIONERO: NIVEL 1
object prisioneroEvee inherits Prisionero {

	const property position = game.at(2, 2)
	
	override method nombre() = "evee"

}

// PRISIONERO: NIVEL 2
object prisioneroPidgeot inherits Prisionero {

	const property position = game.at(6, 4)
	
	override method nombre() = "pidgeot"
	
}

// PRISIONERO: NIVEL 3
object prisioneroVulpix inherits Prisionero {

	const property position = game.at(11, 1)
	
	override method nombre() = "vulpix"

}

// PRISIONERO: NIVEL 4
object prisioneroSquirtle inherits Prisionero {

	const property position = game.at(16, 7)
	
	override method nombre() = "squirtle"

}

// PRISIONERO: NIVEL 5
object prisioneroCharmander inherits Prisionero {

	const property position = game.at(4, 5)
	
	override method nombre() = "charmander"

}

