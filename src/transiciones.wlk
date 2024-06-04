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
		game.onTick(400,"Custodia 2",{james.mover()}) // PONER EN EXTRAS DEL NIVEL
	}		
}

object j {
	method generar(posicion) {
		const jessie = new Jessie(position = posicion, direccion = derecha)
		game.addVisual(jessie)
		game.onTick(400,"Custodia 3",{jessie.mover()}) // PONER EN EXTRAS DEL NIVEL
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

// AMBIENTE: COFRE (CON LLAVE, VACIO) / PARED / PUERTA (ABIERTA, CERRADA) / BOTON

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

object u {
	method generar(posicion) {
		puertasManager.crearPuerta(abierta,posicion)
	}		
}

object n {
	method generar(posicion) {
		puertasManager.crearPuerta(cerrada,posicion)
	}		
}

object t {
	method generar(posicion) {
		game.addVisual(new Boton(position = posicion))
		}
}

// INFORMACIÓN

object f {
	method generar(posicion) {
		game.addVisual(info)
	}
}

// MAPAS DE NIVEL
object mapa {
	 
	method generar(nivel) {
		(0 .. game.width() - 1).forEach({ x => (0 .. game.height() - 1).forEach({ y => self.generarCelda(x, y, nivel)})})
		cofresManager.colocarLLave() 
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
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,_,x,_,_,_,x,_,_,_,_,_,k,x],
		[x,_,_,o,_,_,x,_,_,_,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,_,x,_,_,_,n,_,_,_,_,_,i,x],
		[x,x,n,x,x,x,x,_,_,_,x,x,x,x,x,x,x,x],
		[x,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x],
		[x,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,x],
		[x,x,x,x,u,x,_,_,_,_,_,_,x,x,x,x,x,x],
		[x,_,_,i,_,x,_,_,_,_,_,_,x,_,_,_,_,x],
		[x,_,_,_,_,x,_,_,i,_,_,_,u,_,_,i,o,x],
		[x,_,e,_,_,x,_,_,_,_,_,_,x,_,_,_,_,x],
		[x,_,_,i,_,x,_,i,_,t,_,_,x,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,f]	
	].reverse()
	
	method nivel2() = [ 
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,_,x,_,_,_,w,_,_,x,_,_,_,_,_,x],
		[x,_,_,o,x,_,_,_,_,_,_,x,_,_,p,_,_,x],
		[x,_,_,_,x,_,_,_,_,_,_,u,_,_,_,_,i,x],
		[x,x,n,x,x,_,_,t,_,_,_,x,x,x,x,x,x,x],
		[x,d,_,_,_,_,_,x,x,x,x,_,_,_,_,_,_,x],
		[x,_,_,_,_,_,_,x,_,_,n,_,_,_,_,_,_,x],
		[x,x,u,x,x,x,_,x,o,_,x,_,_,_,_,_,_,x],
		[x,_,_,i,_,x,_,x,x,x,x,_,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,i,_,_,_,n,_,_,i,g,x],
		[x,_,o,_,_,x,_,_,_,_,_,_,x,_,_,_,_,x],
		[x,_,_,i,_,x,_,i,_,k,_,_,x,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]	
	].reverse() // COMPLETAR RESTO 
	
	method nivel3() = [
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,o,x,_,_,_,i,_,x,_,_,_,_,_,k,x],
		[x,_,_,i,x,_,_,_,_,o,x,_,_,_,_,_,_,x],
		[x,_,_,_,x,_,_,_,i,_,x,_,_,_,_,_,i,x],
		[x,x,n,x,x,_,_,_,_,_,x,d,_,_,_,_,_,x],
		[x,_,_,_,u,_,_,_,_,_,x,o,_,_,_,_,_,x],
		[x,_,x,x,x,x,x,x,x,x,x,x,x,x,x,n,x,x],
		[x,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,t,x],
		[x,x,x,x,x,x,x,x,x,u,x,n,x,x,x,x,x,x],
		[x,_,_,_,_,x,_,_,i,_,x,_,_,_,_,i,o,x],
		[x,_,v,_,_,x,_,_,_,_,x,_,_,_,_,_,_,x],
		[x,p,_,i,_,u,_,i,_,_,x,_,_,_,_,_,_,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // COMPLETAR RESTO
	
	method nivel4()= [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,o,_,_,_,_,_,_,_,_,b,x,_,_,s,x],
		[x,n,x,x,x,x,u,x,x,_,x,x,_,n,_,_,_,x],
		[x,_,_,k,_,n,_,x,_,_,n,x,x,x,x,x,x,x],
		[x,x,x,x,x,x,_,x,_,x,_,_,_,x,_,_,_,x],
		[x,_,_,_,_,x,_,x,_,x,_,o,_,x,_,_,_,x],
		[x,_,_,_,_,x,_,x,_,x,_,_,_,x,_,_,_,x],
		[x,_,o,_,_,x,_,x,_,x,_,j,_,x,o,_,_,x],
		[x,_,_,a,_,u,_,_,_,x,_,_,_,x,_,_,_,x],
		[x,x,x,x,x,x,x,x,n,x,x,x,x,x,u,x,x,x],
		[x,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,x],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x]
	].reverse() // COMPLETAR RESTO
	
	method nivel5()= [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x],
		[x,_,_,u,_,x,x,x,x,x,x,x,_,x,_,_,_,x],
		[x,_,_,x,_,_,_,_,_,_,_,x,_,x,u,x,x,x],
		[x,_,_,x,x,x,x,x,x,x,_,x,_,x,_,_,_,x],
		[x,_,_,x,_,_,_,u,_,_,_,x,_,x,_,_,x,x],
		[x,x,_,x,c,_,_,x,x,x,x,x,_,u,_,_,x,x],
		[x,x,_,x,_,_,_,u,_,_,_,x,_,x,_,_,x,x],
		[x,_,_,x,x,x,x,x,x,x,_,x,_,x,_,_,_,x],
		[x,_,_,x,_,_,_,_,_,_,_,x,_,x,x,x,u,x],
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

	method iniciar() {
		portadaManager.presentarMenuInicio()
	}
	
	method generar() {
		if (nivelManager.quedanNiveles()) {
			game.clear()
			mapa.generar(nivelManager.nivelActual())
		} else {
			self.victoria()
		}
	}

	method reset() {
		pikachu.resetear(100)
		nivelManager.resetear()
		self.iniciar()
	}
	
	method resetTemporal(energiaActual) {
		pikachu.resetear(energiaActual)
	}

	method victoria() {
		game.clear()
		portadaManager.presentarVictoria()
	}
	
	method victoriaParcial() {
		nivelManager.aumentarNivelActual()
		self.resetTemporal(pikachu.energia())
		game.schedule(100, { self.generar() })
	}

	method derrota() {
		game.clear()
		portadaManager.presentarDerrota()
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

object inicioDelJuego {
	const property position = game.at(0, 0)
	const property image = "menu-inicial.png"
}

object inicioNivel {
	const property image = "instrucciones-nivel-" + (nivelManager.numeroDeNivel()+1).toString() + ".png"
	const property position = game.at(0,0)
}

object infoJugabilidad {
	const property image = "infoJugabilidad.png"
	const property position = game.at(0,0)
}

object portadaManager {
	const property position = game.at(0,0)
	var property image = "menu-inicial.png"
	
	method presentarMenuInicio() {
		game.addVisual(inicioDelJuego)
		keyboard.enter().onPressDo{self.presentarNivel()}
	}
	
	method presentarNivel() {
		game.clear()
		game.addVisual(inicioNivel)
		keyboard.enter().onPressDo{gameManager.generar()}
	}
	
	method removerVisual() {
		game.removeVisual(self)
	}
	
	method presentarDerrota() {
		game.addVisual(derrota)
	}
	
	method presentarVictoria() {
		game.addVisual(victoria) 
	}
	
	method presentarInfo() {
		game.addVisual(infoJugabilidad)
		keyboard.enter().onPressDo{
			game.removeVisual(infoJugabilidad)
			//game.start()
		}
	}
}

object info {
	const property position = game.at(game.width()-1,0)
	var property image = "info.png"
	
	method mostrarInfo(){
		//game.stop()
		portadaManager.presentarInfo()
	}
}