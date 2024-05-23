import ambiente.*
import config.*
import enemigos.*
import pokemons.*
import posicionamiento.*
import wollok.game.*

object nivelManager {

	const niveles = [mapaDeParedesDelNivel1, 
					mapaDeParedesDelNivel2, 
					mapaDeParedesDelNivel3,
					mapaDeParedesDelNivel4,
					mapaDeParedesDelNivel5]
	var nivelActual = 0

	method numeroDeNivel() = nivelActual+1

	method nivelActual() {
		return niveles.get(nivelActual)
	}

	method aumentarNivelActual() {
		self.validarQueExistenMasNiveles()
		nivelActual++
	}
	
	method validarQueExistenMasNiveles(){
		if(niveles.size()-1 < nivelActual){
			self.error("No existen más niveles")
		}
	}
	method quedanNiveles() = nivelActual < niveles.size()-1
	method reset() {
		nivelActual = 0
	}
	
	method generarNivel() {
		if (self.quedanNiveles()) {
			//game.clear()
			self.nivelActual().agregar()
			//self.nivelActual().iniciar()
			/*mapa.generar(levelManager.nivelActual())
			self.agregarJugador()
			self.generarEnemigosYAumentarDificultad()
			hud.add()*/
		} else {
			self.victoria()
		}
	}
	method victoria() {
		game.clear()
		//game.addVisual(victoria)
	}

}

