import ambiente.*
import config.*
import enemigos.*
import pokemons.*
import posicionamiento.*
import wollok.game.*
import alimentosFrutales.*
import transiciones.*

object menu {	
	const property optionMenu=[start,setup,exit]
 	
	method iniciarMenu(){
		
		config.configurarTeclasMenu()
		
		game.addVisual(cursor)
		
		self.setOptions(optionMenu)
		
	}
	
	method cleanOptions(options){
		options.forEach({option=>game.removeVisual(option)})
	}
	
	method setOptions(options){
		options.forEach({option=>game.addVisual(option)})
	}
}

object cursor{
	const property image="cursor.png"
	var property position=game.at(6,8)
	//var property position=game.at(6,9)
	
	method mover(unaPosicion){
		if(self.validacionDeMovimiento(unaPosicion)){
		self.position(unaPosicion)}
	}
	method action(){
		self.option().forEach({option=>option.action()})
		//solo es 1, pero como es una coleccion, lo tratramos asi
	}
	method option(){
		return game.getObjectsIn(self.position().right(2))
	}
	
	method validacionDeMovimiento(unaPosicion){
		return unaPosicion.x()==6 and unaPosicion.y().between(4,8)
		//return unaPosicion.x()==6 and unaPosicion.y().between(4,9)
	}	
}	
//opciones	
object start{
	var property image="start.png"
	var property position=game.at(8,8)
	method action(){
		//portadaManager.remover()
		portadaManager.presentarMenuInicio()
	}
}

object setup{
	var property image="setup.png"
	var property position=game.at(8,6)
	const property optionSetup=[on,off,back]
	method action(){
		menu.cleanOptions(menu.optionMenu())
		menu.setOptions(optionSetup)
	}
}

object exit{
	var property image="exit.png"
	var property position=game.at(8,4)
	method action(){
		game.stop()
	}
	
}

object on{
	var property image="on.png"
	var property position=game.at(8,8)
	method action(){
		sonidosManager.playMusicFondo()
		game.say(self,"Sonido activado")
	}
}
object off{
	var property image="off.png"
	var property position=game.at(8,6)
	method action(){
		sonidosManager.stopMusicFondo()
		game.say(self,"Sonido desactivado")
	}
}

object back{
	var property image="back.png"
	var property position=game.at(8,4)
	
	method action(){
		menu.cleanOptions(setup.optionSetup())
		menu.setOptions(menu.optionMenu())	
	}	
}