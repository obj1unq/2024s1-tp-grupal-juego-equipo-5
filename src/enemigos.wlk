import alimentos.*
import pokemons.*
import posicionamiento.*
import randomizer.*
import wollok.game.*
import config.*

// EQUIPO ROCKET
class EquipoRocket {

	var property position

	method action() {}
	
	method sonido() = "descVida.wav"
	
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
	
	override method sonido() = "jessie.mp3"
}

class James inherits EquipoRocketConMovimientoVariable {
	
	override method danio() = 100

	override method nombre() = "james"
	
	override method sonido() = "james.mp3"
}

class Meowth inherits EquipoRocketConMovimiento {

	override method danio() = 75

	override method nombre() = "meowth"
	
	override method sonido() = "meowth.mp3"

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
	override method sonido() = "corte-daga.mp3"
}
object dagasManager {

	const dagas = []

	method agregarDaga(daga) {
		dagas.add(daga)
	}

	method crearDaga(posicion, direccion) {
		const daga = new Daga(position = posicion, direccion = direccion)
		self.agregarDaga(daga)
		game.addVisual(daga)
		game.onTick(500, "Custodia" + daga.identity().toString(), {daga.mover()})
	}
	

}
class Pinche inherits EquipoRocket {

	var property estado = desactivado

	override method colision(pokemon) {
		estado.colision(pokemon, self)
	}
	
	override method danio() = estado.danio()

	override method nombre() = "pinches-" + estado.toString()
  
  override method sonido() = "pinche.mp3"
	
  method cambiarEstado() {
		estado = estado.siguiente()
	  self.refreshColision()
  }
    
  method refreshColision() {
	  if (position == pikachu.position()) {
	  	estado.colision(pikachu,self)
	  }
  }
}

object desactivado {

	method colision(pokemon, pinche) {}
	
	method danio() = 0

	method siguiente() {
		return activado
	}
	
}

object activado {

	method colision(pokemon, pinche) {
		sonidosManager.sonar(pinche.sonido())
		pokemon.recibirDanio(pinche)
	}
	
	method danio() = 50

	method siguiente() {
		return desactivado
	}

}
