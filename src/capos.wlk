//artefactos
object espadaDelDestino {

	var nueva = true

	method poder(personaje) {
		return personaje.poderBase() / if (nueva) {1} else {2}
	}

	method usar() {
		nueva = false
	}

}

object libroDeHechizos {

	var property hechizos = []

	method poder(personaje) {
		return if (hechizos.isEmpty()) 0 else hechizos.first().poder(personaje)
	}

	method usar() {
		hechizos = hechizos.drop(1)
	}

}

object collarDivino {

	const puntos = 3
	var property batallas = 0

	method poder(personaje) {
		// otra forma: return puntos + if(personaje.poderBase() > 6) {batallas} else {0}
		if (personaje.poderBase() > 6) {
			return puntos + batallas
		} else {
			return puntos
		}
	}

	method usar() {
		batallas += 1
	}

}

object armaduraDeAceroValyrio {

	method poder(personaje) {
		return 6
	}

	method usar() {
		return 0
	}

}

//hechizos
object bendicion {

	method poder(personaje) {
		return 4
	}

}

object invisibilidad {

	method poder(personaje) {
		return personaje.poderBase() // faltaba "base"
	}

}

object invocacion {

	method poder(personaje) {
		// return personaje.artefactoMasPoderosoDeLaCasa()
		return personaje.poderDelArtefactoMasPoderoso() // el poder que otorga es el poder del artefacto más poderoso del castillo, voy a preguntarle a rolando
	}

}

//personajes
object rolando {

	var property artefactosQueTengo = #{}
	var property capacidadMax = 2
	var property todosLosArtefactos = #{}
	var artefactosEncontrados = []
	var property poderBase = 5
	var property tierra = erethia
	var property enemigosVencibles = #{}
	var property tierrasConquistables = #{}
	var property esPoderoso = false
	var property tieneArtefactoLetal = false
	var property nombreArtefactoLetal

	method agregarArtefacto(nuevoArtefacto) {
		if (artefactosQueTengo.size() < capacidadMax) {
			artefactosQueTengo.add(nuevoArtefacto)
		}
		artefactosEncontrados.add(nuevoArtefacto)
		self.todosLosArtefactos().add(nuevoArtefacto)
	}

	method llegarAlCastillo() {
		castilloDePiedra.artefactos().addAll(self.artefactosQueTengo())
		self.artefactosQueTengo().clear()
	}

	method artefactosEncontrados() {
		return artefactosEncontrados
	}

	method poder() {
		return self.poderBase() + self.sumatoriaDePoderes()
	// faltaba "self".poder"Base"()
	}

	method sumatoriaDePoderes() {
		return artefactosQueTengo.sum({ artefacto => artefacto.poder(self) })
	}

	method batalla() {
		poderBase++
		artefactosQueTengo.forEach({ artefacto => artefacto.usar()})
	}

	// method artefactoMasPoderosoDeLaCasa() {
	// return castilloDePiedra.poderArtefactoMasPoderoso(self)
	// }
	method poderDelArtefactoMasPoderoso() {
		return castilloDePiedra.poderDelArtefactoMasPoderoso(self)
	} // le pregunto a rolando el poder del artefacto más poderoso del castillo, le pregunta al castillo

	method vencerEnemigos(lugar) {
		// si poderenemigo<poderrolando agregar a lista enemigos venciblnes y su tierra a lista de tierras conquistables sino nada --- filter 
		// const overageUsers = users.filter({ user => user.age() >= 18 })
//#{1, 2, 3, 4, 5}.filter { number => number.even() } => Answers #{2, 4}
		enemigosVencibles = lugar.enemigos().filter({ enemigos => enemigos.poder(self) < self.poder() })
		if (enemigosVencibles == lugar.enemigos()) {
			esPoderoso = true
		}
		return enemigosVencibles
	}

	method conquistarTierras() {
		// mapear tierras de enemigos vencibles
		// const ages = users.map({ user => user.age() })
//[1, 2, 3].map { number => number.odd() } => Answers [true, false, true]
//[].map { number => number.odd() } => Answers []
		tierrasConquistables = enemigosVencibles.map({ enemigos => enemigos.morada() })
		return tierrasConquistables
	}

	method artefactoFatal(enemigo) {
		// poderdelenemigo < poderartefacto 
		tieneArtefactoLetal = self.artefactosQueTengo().any({ artefacto => artefacto.poder(self) > enemigo.poder(self) })
			// plants.any({ plant => plant.hasFlowers() })
		nombreArtefactoLetal = self.artefactosQueTengo().findOrDefault({ artefacto => artefacto.poder(self) > enemigo.poder(self) }, 0)
			// [1, 3, 5].findOrDefault({ number => number.even() }, 0) => Answers 0
		return tieneArtefactoLetal
	}

}

object castilloDePiedra {

	var property artefactosDelCastillo = #{}
	var cantidadArtefactos = 0

	method artefactos() {
		return artefactosDelCastillo
	}

	method agregarArtefacto(nuevoArtefacto) {
		artefactosDelCastillo.add(nuevoArtefacto)
	}

	// method poderArtefactoMasPoderoso(personaje) {
	// return artefactosDelCastillo.map({artefactos => artefactos.poder(personaje)}).maxIfEmpty({0})
	// }
	method poderDelArtefactoMasPoderoso(personaje) {
		return artefactosDelCastillo.map({ artefacto => artefacto.poder(personaje) }).maxIfEmpty({ 0 })
	} // rolando le pregunta al castillo el poder del artefacto más poderoso, de la lista de artefactos que tiene, hace otra lista con sus poderes, los compara y devuelve el mayor

}

//lugares
object erethia {

	var property enemigos = #{}

	method agregarEnemigo(nuevoEnemigo) {
		enemigos.add(nuevoEnemigo)
	}

}

//enemigos
object archibaldo {

	var property morada = palacioDeMarmol

	method poder(personaje) {
		return 16
	}

}

object caterina {

	var property morada = fortalezaDeAcero

	method poder(personaje) {
		return 28
	}

}

object astra {

	var property morada = torreDeMarfil

	method poder(personaje) {
		return 14
	}

}

//casas de enemigos
object palacioDeMarmol {

}

object fortalezaDeAcero {

}

object torreDeMarfil {

}

