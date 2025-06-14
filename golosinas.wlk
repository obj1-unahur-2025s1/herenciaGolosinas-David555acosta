/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


class Golosina {
	var peso = 15
	var property libreDeGluten = false
	method peso() = peso

	//method calcularEspacio(estanteria) = peso + 25 < estanteria.lugarDisponible()
	method enOferta() = self.precio() < 25
	method precio()  
}
class Bombon inherits Golosina {
	override method precio() = 6
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
}

class BombonDuro inherits Bombon {
	override method mordisco() {
	  peso = (peso - 1).max(0)
	}

	method gradoDureza() {
	  var dureza = 0
	  if (peso > 12) 
	  {
		dureza = 3
	  } else 
	  {
		if (peso >= 8 and peso <= 12) {
			dureza = 2
		} else {
			dureza = 1
		}
	  }
	  return dureza
	}
}


class Alfajor inherits Golosina {
	override method precio() = 12
	method mordisco() { peso = peso * 0.8 }
	method sabor() = chocolate
}

class Caramelo inherits Golosina(peso = 5 ,libreDeGluten = true ) {
	override method precio() = 12
	method mordisco() { peso = peso - 1.2 }
	var property sabor 
}

class CarameloCorazon inherits Caramelo {
	override method mordisco(){
		super()
		sabor = chocolate
	}
}


class Chupetin inherits Golosina(peso = 7 , libreDeGluten = true){
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
}

class Oblea inherits Golosina(peso = 250) {
	method precio() { return 5 }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
}

class ObleaCrujiente inherits Oblea {
	var cantidadDeMordiscos = 0
	override method mordisco () {
		super()
		if (cantidadDeMordiscos <= 3) {
			peso = peso - 3
		}

		cantidadDeMordiscos += 1
	}

	method estaDebil() = cantidadDeMordiscos > 3 
}

class Chocolatin inherits Golosina{
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	method precio() { return peso * 0.50 }
	override method peso() = pesoInicial - comido.max(0) 
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }

}


class ChocolatinVip inherits Chocolatin{
	var property humedad

	override method peso() = super() + humedad 
}

class ChocolatinPremiun inherits ChocolatinVip {
	var property cobertura

	override method humedad() = super() / 2 
}
class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}