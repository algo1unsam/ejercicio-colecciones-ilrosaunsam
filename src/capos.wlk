object espadaDelDestino {

}

object libroDeHechizos {

}

object collarDivino {

}

object armaduraDeAceroValyrio {

}

object rolando {

	var artefactosQueTengo = #{}
	var property capacidadMax = 2
	var todosLosArtefactos = #{}
	var artefactosEncontrados = []

	method artefactos() {
		return artefactosQueTengo
	}

	method todosLosArtefactos() {
		return todosLosArtefactos
	}

	method agregarArtefacto(nuevoArtefacto) {
		if (artefactosQueTengo.size() < 2) {
			artefactosQueTengo.add(nuevoArtefacto)
		}
		artefactosEncontrados.add(nuevoArtefacto)
		self.todosLosArtefactos().add(nuevoArtefacto)
		
	}

	method llegarAlCastillo() {
		castilloDePiedra.artefactos().addAll(self.artefactos())
		self.artefactos().clear()
	}


	method artefactosEncontrados() {
		return artefactosEncontrados
	}

}

object castilloDePiedra {

	var artefactosDelCastillo = #{}
	var cantidadArtefactos = 0

	method artefactos() {
		return artefactosDelCastillo
	}

	method agregarArtefacto(nuevoArtefacto) {
		artefactosDelCastillo.add(nuevoArtefacto)
	}

}

