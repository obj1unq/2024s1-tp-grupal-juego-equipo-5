import alimentosFrutales.*
import pokemons.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// AMBIENTACION CON COLISIONES
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

/////EQUIPO ROCKET
class EquipoRocketConMovimiento inherits EquipoRocket {

	const escenario = tablero
	var property direccion

	method mover() {
		if (not self.puedeMover(direccion)) {
			direccion = direccion.opuesto()
		}
		self.position(direccion.siguiente(self.position()))
	}

	method puedeMover(dir) {
		return escenario.puedeIr(self.position(), dir)
	}

}

class Jessie inherits EquipoRocketConMovimiento {
  const property direcciones = [arriba,derecha,abajo,izquierda]
	
	override method danio() = 150

	override method nombre() = "jessie"
	
	override method mover() {
		self.position(self.direccionesPosibles().anyOne().siguiente(self.position()))
	}
	
	method direccionesPosibles(){
		return self.direcciones().filter( { direccion => self.puedeMover(direccion)})
	}

}


class James inherits Jessie {
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

