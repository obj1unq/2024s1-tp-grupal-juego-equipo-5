import alimentos.*
import ambiente.*
import posicionamiento.*
import randomizer.*
import transiciones.*
import wollok.game.*
import config.*

// DETECTIVE
object pikachu {

	var property estado = caminando
	var property direccion = derecha
	var property position = game.at(1,1)
	var property heRescatadoAlPrisionero = false // HAY UN SOLO PRISIONERO POR NIVEL
	var property energia = 100
	var property tieneLlave = false // HAY UNA SOLA LLAVE POR NIVEL
	const miEscenario = tablero

	method estado(estadoACambiar) {
		if (estado != estadoACambiar) {
			estado = estadoACambiar
			estado.activar(self)
		}
	}

	method image() = estado.image()

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
		sonidosManager.sonar("descVida.wav")
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
		return estado.puedeMover() && miEscenario.puedeIr(self.position(), dir)
	}

	method obtenerLlave() {
		tieneLlave = true
	}

	method liberarPokemon() {
		sonidosManager.sonar("liberarPokemon.mp3")
		heRescatadoAlPrisionero = true
		tieneLlave = false
	}

	method esAtravesable() = true

	method interactuarConObjeto() {
		const posiciones = #{ direccion.siguiente(self.position()), 
							  direccion.opuesto().siguiente(self.position()), 
							  direccion.anterior().siguiente(self.position()), 
							  direccion.siguiente().siguiente(self.position()) }
		const objetos = posiciones.flatMap({ pos => game.getObjectsIn(pos) })
		if (objetos.isEmpty()) {
			self.error("Aqui no hay nada")
		}
		objetos.forEach({ objeto => objeto.action()})
	}
	
	method resetear(energiaReset) {
		self.energia(energiaReset) 
		self.tieneLlave(false)
		self.heRescatadoAlPrisionero(false)
		self.estado(caminando)
	}

}

// ESTADOS DEL DETECTIVE
object caminando {

	var property aspecto = "derecha"

	method image() = "caminando-" + aspecto + ".png"

	method puedeMover() = true

	method activar(pokemon) {
	}

}

object ganador {

	var property aspecto = ""

	method image() = "ganador.png"

	method puedeMover() = false

	method activar(pokemon) {
		game.say(pokemon, "Lo logré!")
		gameManager.victoriaParcial()
	}

}

object muerto {

	var property aspecto = ""

	method image() = "muerto.png"

	method puedeMover() = false

	method activar(pokemon) {
		game.say(pokemon, "Perdí!")
		game.schedule(1000, { gameManager.derrota() })
	}

}

// POKEBOLA
class Pokebola {

	var property position
	const miPokemon = pikachu
	const property image = "pokebola.png"

	method esAtravesable() = miPokemon.heRescatadoAlPrisionero()

	method colision(pokemon) {
		pokemon.estado(ganador)
		game.schedule(500, { game.removeVisual(self)})
	}
	method action(){}
}

// POKEMONS PRISIONEROS
class Prisionero {

	const rescatador = pikachu
	var property preso = true

	method action() {
	}

	method colision(pokemon) {
		pokemon.liberarPokemon()
		self.liberar()
		llave.ocultar()
		game.say(self, "Gracias por liberarme!")
		game.schedule(2000, { game.removeVisual(self)})
	}

	method encarcelar() {
		preso = true
	}
	
	method esAtravesable() = rescatador.tieneLlave()

	method image() {
		return if (not self.preso()) {
			"libre-"
		} else {
			"preso-" 
		}
		+ self.nombre() + ".png"
	}

	method liberar() {
		preso = false
		prisionerosLiberados.agregar(self)
	}

	method nombre()

}

object prisionerosLiberados {
	
	const liberados = #{}
	
	method agregar(liberado) {
		liberados.add(liberado)
	}
	
	method encarcelarATodos() {
		liberados.forEach({ liberado => liberado.encarcelar() })
	}
	
	method resetear() {
		self.encarcelarATodos()
		self.vaciar()
	}
	
	method vaciar() {
		liberados.clear()
	}
}

// PRISIONERO: NIVEL 1
object prisioneroEvee inherits Prisionero {

	var property position = game.at(2, 2)
	
	override method nombre() = "evee"

}

// PRISIONERO: NIVEL 2
object prisioneroPidgeot inherits Prisionero {

	var property position = game.at(6, 4)

	override method nombre() = "pidgeot"

}

// PRISIONERO: NIVEL 3
object prisioneroVulpix inherits Prisionero {

	var property position = game.at(11, 1)

	override method nombre() = "vulpix"

}

// PRISIONERO: NIVEL 4
object prisioneroSquirtle inherits Prisionero {

	var property position = game.at(16, 7)

	override method nombre() = "squirtle"

}

// PRISIONERO: NIVEL 5
object prisioneroCharmander inherits Prisionero {

	var property position = game.at(4, 5)

	override method nombre() = "charmander"

}
