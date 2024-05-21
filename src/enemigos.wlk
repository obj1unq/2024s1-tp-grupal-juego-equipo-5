import alimentosFrutales.*
import objects.*
import posicionamiento.*
import randomizer.*
import wollok.game.*

// AMBIENTACION CON COLISIONES
class Enemigo {

	const escenario = tablero
	var property position

	method colision(pokemon) {
		pokemon.recibirDanio(self)
	}
	
	method danio()
	
	method esAtravesable() = true

	method image()
	
	method mover() {}
	
	method action(){}
	
}



/////EQUIPO ROCKET
class EquipoRocket inherits Enemigo {

	var property direccion
	  
	override method image() = "equipo-rocket-"

	override method mover() {
		self.validarDireccion()
		self.position(direccion.siguiente(self.position()))
	}

	method validarDireccion() {
		if (not self.puedeMover(direccion)) {
			direccion = direccion.opuesto()
		}
	}
	
	method puedeMover(dir) {
		return escenario.puedeIr(self.position(), dir)
	}
	
}

class Jessie inherits EquipoRocket {
	override method danio() = 150
	override method image() = super() + "jessie.png"

}

class James inherits EquipoRocket {
	override method danio() = 100
	override method image() = super() + "james.png"

}

class Meowth inherits EquipoRocket {

	override method danio() = 75

	override method image() = super() + "meowth.png"

}

class Daga inherits EquipoRocket {
	
	var property inicial = position
		
	override method danio()  = 30

	override method image() = "trampa-daga.png"

	override method mover() {
		if (not self.puedeMover(direccion)) {
			self.position(inicial)
		} else {
			self.position(direccion.siguiente(self.position()))		
		}
	}
	
}

class Pinche inherits Enemigo {

	override method colision(pokemon){ 
		super(pokemon) 
		game.removeVisual(self)
	}
	
	override method danio() = 50

	override method image() = "trampa-pinches.png"

}


