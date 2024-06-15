import alimentosFrutales.*
import pokemons.*
import posicionamiento.*
import randomizer.*
import wollok.game.*
import config.*

// EQUIPO ROCKET
class EquipoRocket {

	var property position

	method action() {
	}
	
	method sonido() = "descVida.wav" //Por ahora, hasta que encuentre mas sonidos reproducibles
	
	method colision(pokemon) {
		sonidosManager.sonar(self.sonido())
		pokemon.recibirDanio(self)
	}

	method danio()

	method esAtravesable() = true

	method image() = "equipo-rocket-" + self.nombre() + ".png"

	method nombre()

}

class EquipoRocketConMovimiento inherits EquipoRocket {
	
	const escenario = tablero
	var property direccion
	
	method direccionDeCambio() = direccion.opuesto()
	
	method mover() {
		if (not self.puedeMover(direccion)) {
			direccion = self.direccionDeCambio()
		}
		self.position(direccion.siguiente(self.position())) 
	}
	
	method puedeMover(dir) {
		return escenario.puedeIr(self.position(), dir)
	}
	
}

class EquipoRocketConMovimientoVariable inherits EquipoRocketConMovimiento {
	
	const property direcciones = [arriba,derecha,abajo,izquierda]
	
	override method direccionDeCambio() = self.direccionNueva() 
	
	method direccionesPosibles() {
		return self.direcciones().filter({ direccion => self.puedeMover(direccion) })
	}
	
	method direccionNueva() {
		return self.direccionesPosibles().anyOne()
	}

}
	
class Jessie inherits EquipoRocketConMovimientoVariable {
    
	override method danio() = 150

	override method nombre() = "jessie"
	
}

class James inherits EquipoRocketConMovimientoVariable {
	
	override method danio() = 100

	override method nombre() = "james"

}

class Meowth inherits EquipoRocketConMovimiento {

	override method danio() = 75

	override method nombre() = "meowth"

}

class Daga inherits EquipoRocketConMovimiento {

	var property inicial = position

	override method danio() = 30

	override method nombre() = "daga-va-para-" + direccion.toString()

	override method mover() {
		if (not self.puedeMover(direccion)) {
			self.position(inicial)
		} else {
			self.position(direccion.siguiente(self.position()))
		}
	}
	override method sonido() = "daga.wav"
}

class Pinche inherits EquipoRocket {

	var property estado = desactivado

	override method danio() = estado.danio()

	override method nombre() = "pinches-" + estado.toString()

	method cambiarEstado() {
		estado = estado.siguiente()
	}
	
	override method sonido() = "pinches.wav"
}

object desactivado {

	method danio() = 0

	method colision(pokemon) {
	}

	method siguiente() {
		return activado
	}

}

object activado {

	method danio() = 50

	method colision(pokemon) {
		pokemon.recibirDanio(self)
	}

	method siguiente() {
		return desactivado
	}

}

