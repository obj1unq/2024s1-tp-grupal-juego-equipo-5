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
		game.say(pokemon, "Ay! me dolió")
	}
	
	method danio()
	
	method esAtravesable() = true

	method image()
	
	method mover() {}
	
	method puedeMover(dir) {
		return escenario.puedeIr(self.position(), dir)
	}
	
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

class Trampa inherits Enemigo {

	method nombre()
	
	override method image() = "trampa-" + self.nombre() +".png"

}

class Daga inherits Trampa {
	
	var property inicial = position
	
	var property direccion
	
	override method danio()  = 30

	override method nombre() = "daga"

	override method mover() {
		if (not self.puedeMover(direccion)) {
			self.position(inicial)
		} else {
			self.position(direccion.siguiente(self.position()))		
		}
	}
	
}

class Pinche inherits Trampa {

	override method colision(pokemon){ 
		super(pokemon) 
		game.removeVisual(self)
	}
	
	override method danio() = 50

	override method nombre() = "pinches"

}


