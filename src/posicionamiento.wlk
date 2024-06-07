import alimentosFrutales.*
import pokemons.*
import wollok.game.*

//DIRECCIONES 
object arriba {

	method siguiente(position) {
		return position.up(1)
	}
	
	method opuesto() {
		return abajo
	}
	method anterior(){
		//return derecha
		return izquierda
	}
	method siguiente(){
		//return izquierda
		return derecha
	}
}

object abajo {

	method siguiente(position) {
		return position.down(1)
	}
	
	method opuesto() {
		return arriba
	}
	method anterior(){
		//return izquierda
		return derecha
	}
	method siguiente(){
		//return derecha
		return izquierda
	}
}

object izquierda {

	method siguiente(position) {
		return position.left(1)
	}
	
	method opuesto() {
		return derecha
	}
	method anterior(){
		return abajo
	}
	method siguiente(){
		return arriba
	}
}

object derecha {

	method siguiente(position) {
		return position.right(1)
	}
	
	method opuesto() {
		return izquierda
	}
	method anterior(){
		return arriba
	}
	method siguiente(){
		return abajo
	}
}

// TABLERO
object tablero {

	method pertenece(position) {
		return position.x().between(0, game.width()  - 1) 
			   && 
			   position.y().between(0, game.height() - 2)
	}

	method puedeIr(desde, dir) {
		const haciaDondeVoy = dir.siguiente(desde)
		return self.pertenece(haciaDondeVoy) 
			   && 
			   not self.hayObstaculo(haciaDondeVoy)
	}

	method hayObstaculo(position) {
		const visuales = game.getObjectsIn(position)
		return visuales.any({ visual => not visual.esAtravesable() })
	}

}