import alimentosFrutales.*
import pokemons.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// AMBIENTACION CON COLISIONES
class EquipoRocket {

	var property position

	method action(){
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
	
	override method danio() = 150
	
	override method nombre() = "jessie"

}

class James inherits EquipoRocketConMovimiento {
	
	override method danio() = 100
	
	override method nombre() = "james"

}

class Meowth inherits EquipoRocketConMovimiento {

	override method danio() = 75

	override method nombre() = "meowth"

}

class Daga inherits EquipoRocketConMovimiento {
	
	var property inicial = position
		
	override method danio()  = 30

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

	override method colision(pokemon){ 
		super(pokemon) 
		game.removeVisual(self)
	}
	
	override method danio() = 50

	override method nombre() = "pinche"
	
}

