import alimentosFrutales.*
import pokemons.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// EQUIPO ROCKET
class EquipoRocket {

	var property position

	method action() {
	}

	method colision(pokemon) {
		pokemon.recibirDanio(self)
	}

	method danio()

	method esAtravesable() = true

	method image() = "equipo-rocket-" + self.nombre() + ".png"

	method nombre()

}

class EquipoRocketConMovimiento inherits EquipoRocket {
	
	const escenario = tablero
	
	method mover()
	
	method puedeMover(dir) {
		return escenario.puedeIr(self.position(), dir)
	}
	
}

class EquipoRocketConDireccionFija inherits EquipoRocketConMovimiento {

	var property direccion

	override method mover() {
		if (not self.puedeMover(direccion)) {
			direccion = direccion.opuesto()
		}
		self.position(direccion.siguiente(self.position()))
	}

}

class EquipoRocketConDireccionVariable inherits EquipoRocketConMovimiento {
	
	const property direcciones = [arriba,derecha,abajo,izquierda]
	
	override method mover() {
		self.position(self.unaDireccionPosible().siguiente(self.position()))
	}
	
	method unaDireccionPosible(){
		return self.direcciones().find( { direccion => self.puedeMover(direccion)})
	}

}
	
class Jessie inherits EquipoRocketConDireccionVariable {
    
	override method danio() = 150

	override method nombre() = "jessie"
	
}

class James inherits EquipoRocketConDireccionVariable {
	
	override method danio() = 100

	override method nombre() = "james"

}

class Meowth inherits EquipoRocketConDireccionFija {

	override method danio() = 75

	override method nombre() = "meowth"

}

class Daga inherits EquipoRocketConDireccionFija {

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

}

class Pinche inherits EquipoRocket {

	var property estado = desactivado

	override method danio() = estado.danio()

	override method nombre() = "pinches-" + estado.toString()

	method cambiarEstado() {
		estado = estado.siguiente()
	}

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

