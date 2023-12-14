class Empleado {
  var property lenguajes = []
  var property aniosExperiencia = 0
  var property esCopado = false
  var property estaInvitado = false
  var property mesa = 0
  
  method aprenderLenguaje(lenguaje) {
    lenguajes.add(lenguaje)
  }
  
  method estaInvitadoAlFestejo() {
    return esCopado || (lenguajes.any({ lenguaje => lenguaje == "Wollok" }) || lenguajes.any({ lenguaje => lenguaje.esAntiguo() }))
  }
  
  method asistir(empresa) {
    if (estaInvitado) {
      empresa.agregarAsistente(self)
      mesa.agregarAsistente(self)
    }
  }
}

class Desarrollador inherits Empleado {
  override method esCopado() {
    return lenguajes.any({ lenguaje => lenguaje.esAntiguo() }) && lenguajes.any({ lenguaje => not(lenguaje.esAntiguo()) })
  }
}

class Infraestructura inherits Empleado {
  override method esCopado() {
    return aniosExperiencia > 10
  }
  
  override method estaInvitadoAlFestejo() {
    return lenguajes.size() >= 5 || esCopado
  }
}

class Jefe inherits Empleado {
  var property empleadosACargo = []
  var property mesaJefes = 99

  method tomarACargo(empleado) {
    empleadosACargo.add(empleado)
  }
  
  override method esCopado() {
    return empleadosACargo.all({ empleado => empleado.esCopado() }) && lenguajes.any({ lenguaje => lenguaje.esAntiguo() })
  }
  
  override method estaInvitadoAlFestejo() {
    return esCopado
  }
}

class Empresa {
  var property empleados = []
  var property asistentes = []

  method agregarEmpleado(empleado) {
    empleados.add(empleado)
  }

  method agregarAsistente(asistente) {
    asistentes.add(asistente)
  }

  method obtenerListaDeInvitados() {
    return empleados.filter({empleado => empleado.estaInvitadoAlFestejo()})
  }
}

class Fiesta {
  var property costo = 200000
  var property mesas = []
  var property empresa

 method calcularBalance() {
    empresa.asistentes.sum({ asistente => asistente.mesa * 1000 }) - costo
  }
  method fueUnExito() {
    calcularBalance() > 0 && empresa.asistentes.size() == empresa.empleados.size()
  }
  
 method mesaConMasAsistentes() {
    mesas.max({ mesa => mesa.asistentes.size() })
  }
}

class Mesas {
  var property numero
  var property asistentes = []

  method agregarAsistente(asistente) {
    asistentes.add(asistente)
  }
}

