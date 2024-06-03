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

// EQUIPO ROCKET: DAGA (ABAJO, ARRIBA, DERECHA, IZQUIERDA) / JAMES / JESSIE / MEOWTH / PINCHE

object w {
	method generar(posicion) {
		const daga = new Daga(position = posicion, direccion = abajo)
		game.addVisual(daga)
		game.onTick(300,"Custodia 0",{daga.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object y {
	method generar(posicion) {
		const daga = new Daga(position = posicion, direccion = arriba)
		game.addVisual(daga)
		game.onTick(300,"Custodia 0",{daga.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object d {
	method generar(posicion) {
		const daga = new Daga(position = posicion, direccion = derecha)
		game.addVisual(daga)
		game.onTick(300,"Custodia 0",{daga.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object b {
	method generar(posicion) {
		const daga = new Daga(position = posicion, direccion = izquierda)
		game.addVisual(daga)
		game.onTick(300,"Custodia 0",{daga.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object a {
	method generar(posicion) {
		const james = new James(position = posicion, direccion = arriba)
		game.addVisual(james)
		game.onTick(300,"Custodia 2",{james.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object j {
	method generar(posicion) {
		const jessie = new Jessie(position = posicion, direccion = derecha)
		game.addVisual(jessie)
		game.onTick(200,"Custodia 3",{jessie.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object m {
	method generar(posicion) {
		const meowth = new Meowth(position = posicion, direccion = derecha)
		game.addVisual(meowth)
		game.onTick(300,"Custodia 1",{meowth.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object i {
	method generar(posicion) {
		const pinche =new Pinche(position = posicion)
		game.addVisual(pinche)
		game.onTick(800,"Pinche",{pinche.cambiarEstado()})
	}		
}

// AMBIENTE: COFRE (CON LLAVE, VACIO) / PARED / PUERTA (ABIERTA, CERRADA)



object o {
	method generar(posicion) {
		const cofre = new Cofre(position = posicion)
		cofresManager.agregarCofre(cofre)
		game.addVisual(cofre)
	}	
}

object x {
	method generar(posicion) {
		game.addVisual(new Pared(position = posicion))
	}		
}
//puerta abierta
object u1 {
	method generar(posicion) {
		puertasManager.crearPuerta(abierta,posicion)
	}		
}
//puerta cerrada
object u2 {
	method generar(posicion) {
		puertasManager.crearPuerta(cerrada,posicion)
	}		
}

//////////////////////////////////////////////////////////////

object t {
	method generar(posicion) {
		game.addVisual(new Boton(position = posicion))
	}
}
// falta puerta cerrada, la de arriba hacer que sea abierta.

// MAPAS DE NIVEL
object mapa {
	 
	method generar(nivel) {
		(0 .. game.width() - 1).forEach({ x => (0 .. game.height() - 1).forEach({ y => self.generarCelda(x, y, nivel)})})
		game.ground("piso.png")
		game.addVisual(pikachu)
		// REVISAR SI ESTO DEBE IR ACÁ O EN NIVEL MANAGER
		anotador.generarVisuales()
		config.teclas()
		config.colisiones()
		config.frutas()
		cofresManager.colocarLLave()
		// ---------------------------------------------- 
	}

	method generarCelda(x, y, nivel) {
		const celda = nivel.get(y).get(x)
		celda.generar(game.at(x, y))
	}

}

object escenario {

	method nivel2() = [ //este es el 1
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,_,x,_,_,_,x,_,_,_,_,_,k,x],
		[x,_,_,o,_,_,x,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,_,x,_,_,_,u2,_,_,_,_,_,i,x],
		[x,x,u2,x,x,x,x,_,_,_,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x],
		[x,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,x],
		[x,x,x,x,u1,x,_,_,_,_,_,_,x,x,x,x,x,x],
		[x,_,_,i,_,x,_,_,_,_,_,_,x,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,i,_,_,_,u1,_,_,i,o,x],
		[x,_,e,_,_,x,_,_,_,_,_,_,x,_,_,_,_,x],
		[x,_,_,i,_,x,_,i,_,t,_,_,x,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]	
	].reverse()
	
	method nivel1() = [ 
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,x,_,_,_,w,_,_,x,_,_,_,_,_,x],
		[x,_,_,o,x,_,_,_,_,_,_,x,_,_,p,_,_,x],
		[x,_,_,_,x,_,_,_,_,_,_,u1,_,_,_,_,i,x],
		[x,x,u2,x,x,_,_,t,_,_,_,x,x,x,x,x,x,x],
		[x,d,_,_,_,_,_,x,x,x,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,_,_,x,_,_,u2,_,_,_,_,_,_,x],
		[x,x,u1,x,x,x,_,x,o,_,x,_,_,_,_,_,_,x],
		[x,_,_,i,_,x,_,x,x,x,x,_,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,i,_,_,_,u2,_,_,i,g,x],
		[x,_,o,_,_,x,_,_,_,_,_,_,x,_,_,_,_,x],
		[x,_,_,i,_,x,_,i,_,k,_,_,x,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]	
	].reverse() // COMPLETAR RESTO 
	
	method nivel3() = [//el viejo nivel 1
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,o,x,_,_,_,i,_,x,_,_,_,_,_,k,x],
		[x,_,_,i,x,_,_,_,_,o,x,_,_,_,_,_,_,x],
		[x,_,_,_,x,_,_,_,i,_,x,_,_,_,_,_,i,x],
		[x,x,u2,x,x,_,_,_,_,_,x,d,_,_,_,_,_,x],
		[x,_,_,_,u1,_,_,_,_,_,x,o,_,_,_,_,_,x],
		[x,_,x,x,x,x,x,x,x,x,x,x,x,x,x,u2,x,x],
		[x,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,t,x],
		[x,x,x,x,x,x,x,x,x,u1,x,u2,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,i,_,x,_,_,_,_,i,o,x],
		[x,_,e,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,p,_,i,_,u1,_,i,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // COMPLETAR RESTO
	
	method nivel4()= [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,_,_,_,x,_,_,_,_,x,_,_,_,x],
		[x,u2,x,x,x,x,u1,x,x,_,x,x,_,u1,_,_,_,x],
		[x,_,_,_,_,u1,_,x,_,_,u2,x,x,x,x,x,x,x],
		[x,x,x,x,x,x,_,x,_,x,_,_,_,x,_,_,_,x],
		[x,_,_,_,_,x,_,x,_,x,_,_,_,x,_,_,x,x],
		[x,_,_,_,_,x,_,x,_,x,_,_,_,x,_,_,x,x],
		[x,_,_,_,_,x,_,x,_,x,_,_,_,x,_,_,x,x],
		[x,_,_,_,_,u1,_,_,_,x,_,_,_,x,_,_,x,x],
		[x,x,x,x,x,x,x,x,u2,x,x,x,x,x,u1,x,x,x],
		[x,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // COMPLETAR RESTO
	
	method nivel5()= [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,u1,_,x,x,x,x,x,x,x,_,x,_,_,_,x],
		[x,_,_,x,_,_,_,_,_,_,_,x,_,x,u1,x,x,x],
		[x,_,_,x,x,x,x,x,x,x,_,x,_,x,_,_,_,x],
		[x,_,_,x,_,_,_,u1,_,_,_,x,_,x,_,_,x,x],
		[x,x,_,x,_,_,_,x,x,x,x,x,_,u1,_,_,x,x],
		[x,x,_,x,_,_,_,u1,_,_,_,x,_,x,_,_,x,x],
		[x,_,_,x,x,x,x,x,x,x,_,x,_,x,_,_,_,x],
		[x,_,_,x,_,_,_,_,_,_,_,x,_,x,x,x,u1,x],
		[x,_,_,x,_,x,x,x,x,x,x,x,_,x,_,_,_,x],
		[x,p,_,x,_,_,_,_,_,_,_,_,_,x,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // COMPLETAR RESTO
	
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
		// PONER UN IR A INICIO PARA INICIAR LA PRESENTACION...
		self.generar() // SACAR cuando el inicio este listo, meterlo ahí...
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
		self.resetTemporal()
		game.schedule(100, { self.generar() })
	}

	method derrota() {
		game.clear()
		game.addVisual(derrota)
		game.schedule(4000, { self.reset() })
	}
		// MUCHO CÓDIGO REPETIDO, FUNCIONA PERO OJO AL PONER CAMBIOS POR LAS TRANSICIONES 
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

