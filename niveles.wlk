import fallingObjects.*
import fondosDelJuego.*
import fasesDelJuego.*
import snorlax.*

class Nivel {
    const property fondo
    const property probabilidadBasura
    const property tiempoCaida
    const property siguienteNivel
    const property puntosMinimosParaNextLevel
    const property puedeSubirNivel = true
    const property nombre

    method inicializar() {
        self.añadirFondo()
        self.actualizarDificultad()
    }

    method añadirFondo() {
        game.addVisual(fondo)
    }

    method removerFondo() {
        game.removeVisual(fondo)
    }

    method puedeSubirDeNivel() {
        return puedeSubirNivel && self.hayMinimoDePuntos()
    }

    method hayMinimoDePuntos() {
        return puntuacion.puntos() >= puntosMinimosParaNextLevel
    }

    method actualizarDificultad() {
        juego.removerMecanicas()
        juego.aplicarMecanicas()
        fallingObjectsDelJuego.añadirItemAlAzar()
    }
}

//Niveles del juego
const nivelFacil = new Nivel(
    nombre =                        "Facil",
    fondo =                 fondoNivelFacil, 
    probabilidadBasura =                 25, 
    tiempoCaida =                       0.5, 
    siguienteNivel =            nivelNormal,
    puntosMinimosParaNextLevel =       3000
)

const nivelNormal = new Nivel(
    nombre =                       "Normal",
    fondo =                fondoNivelNormal, 
    probabilidadBasura =                 45, 
    tiempoCaida =                         1, 
    siguienteNivel =           nivelDificil,
    puntosMinimosParaNextLevel =       6000
)

const nivelDificil = new Nivel(
    nombre =                      "Dificil",
    fondo =               fondoNivelDificil, 
    probabilidadBasura =                 60, 
    tiempoCaida =                       1.5, 
    siguienteNivel =             nivelFacil, // dado que no se puede subir de nivel, no tiene mucho sentido completar esto.
    puntosMinimosParaNextLevel =   10**(20),
    puedeSubirNivel =                 false
)
