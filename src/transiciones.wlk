import ambiente.*
import config.*
import enemigos.*
import pokemons.*
import posicionamiento.*
import wollok.game.*

// VACIO
object _ {
	
	method generar(position) {
		// El vacio no agrega nada
	}
		
}

// POKEBOLA
object k {
	
	method generar(posicion) {
		game.addVisual(new Pokebola(position = posicion))
	}
			
}

// DETECTIVE / PRISIONEROS
object p {
	
	method generar(posicion) {
		pikachu.position(posicion)
		//No agrega el visual para hacerlo al final
	}
			
}

object e {
	
	method generar(posicion) {
		prisioneroEvee.position(posicion)
		game.addVisual(prisioneroEvee)
	}
			
}

object g {
	
	method generar(posicion) {
		prisioneroPidgeot.position(posicion)
		game.addVisual(prisioneroPidgeot)
	}
		
}

object v {
	
	method generar(posicion) {
		prisioneroVulpix.position(posicion)
		game.addVisual(prisioneroVulpix)
	}
			
}

object s {
	
	method generar(posicion) {
		prisioneroSquirtle.position(posicion)
		game.addVisual(prisioneroSquirtle)
	}
			
}

object c {
	
	method generar(posicion) {
		prisioneroCharmander.position(posicion)
		game.addVisual(prisioneroCharmander)
	}
			
}

// EQUIPO ROCKET: DAGA / JAMES / JESSIE / MEOWTH / PINCHE
object d {
	method generar(posicion) {
		const daga = new Daga(position = posicion, direccion = izquierda)
		game.addVisual(daga)
		game.onTick(300,"Custodia 0",{daga.mover()})
	}		
}

object a {
	method generar(posicion) {
		const james = new James(position = posicion, direccion = arriba)
		game.addVisual(james)
		game.onTick(300,"Custodia 2",{james.mover()})
	}		
}

object j {
	method generar(posicion) {
		const jessie = new Jessie(position = posicion, direccion = derecha)
		game.addVisual(jessie)
		game.onTick(200,"Custodia 3",{jessie.mover()})
	}		
}

object m {
	method generar(posicion) {
		const meowth = new Meowth(position = posicion, direccion = derecha)
		game.addVisual(meowth)
		game.onTick(300,"Custodia 1",{meowth.mover()})
	}		
}

object i {
	method generar(posicion) {
		game.addVisual(new Pinche(position = posicion))
	}		
}

// AMBIENTE: COFRE CON LLAVE / COFRE VACIO / PARED / PUERTA
object l {
	method generar(posicion) {
		game.addVisual(new Cofre(position = posicion, contenido = llave))
	}	
}

object o {
	method generar(posicion) {
		game.addVisual(new Cofre(position = posicion))
	}	
}

object x {
	method generar(posicion) {
		game.addVisual(new Pared(position = posicion))
	}		
}

object u {
	method generar(posicion) {
		game.addVisual(new Puerta(position = posicion))
	}		
}

// MAPAS DE NIVEL
object mapa {
	 
	method generar(nivel) {
		(0 .. game.width() - 1).forEach({ x => (0 .. game.height() - 1).forEach({ y => self.generarCelda(x, y, nivel)})})
		game.boardGround("fondo.png")
		game.addVisual(pikachu)
		anotador.generarVisuales()
		config.teclas()
		config.colisiones()
		config.frutas()
	}

	method generarCelda(x, y, nivel) {
		const celda = nivel.get(y).get(x)
		celda.generar(game.at(x, y))
	}

}

object escenario {

	method nivel1() = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,l,x,_,_,_,_,o,x,_,_,_,_,_,k,x],
		[x,_,_,i,x,_,_,_,i,_,x,_,_,_,_,_,i,x],
		[x,x,u,x,x,_,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,u,_,_,_,_,d,x,o,_,_,_,_,_,x],
		[x,_,x,x,x,x,x,x,x,x,x,x,x,x,x,x,u,x],
		[x,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,x],
		[x,x,x,x,x,x,x,x,x,u,x,u,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,i,_,x,_,_,_,_,i,o,x],
		[x,_,e,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,p,_,i,_,u,_,i,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]	
	].reverse()
	
	method nivel2() = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,u,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,u,x,x,x,x,x,x,x,x,x,u,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,u,x,x,x,x,x,x,x,u,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,u,_,_,_,_,_,_,x],
		[x,p,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]	
	].reverse() // COMPLETAR RESTO 
	
	method nivel3() = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,u,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,u,x,x,x,x,x,x,x,x,x,u,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,u,x,x,x,x,x,x,x,u,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,u,_,_,_,_,_,_,x],
		[x,p,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // HACER
	
	method nivel4()= [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,u,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,u,x,x,x,x,x,x,x,x,x,u,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,u,x,x,x,x,x,x,x,u,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,u,_,_,_,_,_,_,x],
		[x,p,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // HACER
	
	method nivel5()= [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,u,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,u,x,x,x,x,x,x,x,x,x,u,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,u,x,x,x,x,x,x,x,u,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,_,_,u,_,_,_,_,_,_,x],
		[x,p,_,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // HACER
	
	method niveles() {
		return [
				self.nivel1(),
				self.nivel2(),
				self.nivel3(),
				self.nivel4(),
				self.nivel5()
		]
	}
	
}

object nivelManager {

	const niveles = escenario.niveles()
	var nivelActual = 0

	method numeroDeNivel() = nivelActual

	method nivelActual() {
		return niveles.get(nivelActual)
	}

	method aumentarNivelActual() {
		self.validarQueExistenMasNiveles()
		nivelActual += 1
	}
	
	method validarQueExistenMasNiveles(){
		if(not self.quedanNiveles()){
			self.error("No existen más niveles")
		}
	}
	
	method quedanNiveles() {
		return nivelActual < (niveles.size() - 1)
	}
	
	method resetear() {
		nivelActual = 0
	}

}

object gameManager {

	method generar() {
		if (nivelManager.quedanNiveles()) {
			game.clear()
			mapa.generar(nivelManager.nivelActual())
		} else {
			self.victoria()
		}
	}

	method reset() {
		pikachu.resetear()
		nivelManager.resetear()
		self.generar()
	}
	
	method resetTemporal() {
		pikachu.resetear()
	}

	method victoria() {
		game.clear()
		game.addVisual(victoria)
	}
	
	method victoriaParcial() {
		nivelManager.aumentarNivelActual()
		transicion.nivel(nivelManager.numeroDeNivel())
		game.schedule(100, { self.generar() })
	}

	method derrota() {
		game.clear()
		game.addVisual(derrota)
		game.schedule(4000, { self.reset() })
	}

}

object victoria {

	const property position = game.at(0, 0)
	const property image = "victoria.png"

}

object derrota {

	const property position = game.at(0, 0)
	const property image = "derrota.png"

}

object transicion {
	method nivel(num) {
		// IMAGEN DE TRANSICION SEGUN EL NIVEL
	}
}

// FALTA LA PRESENTACION Y DESPUES LA INFORMACION DE CADA NIVEL, DAR AMBIENTE DE JUEGO

