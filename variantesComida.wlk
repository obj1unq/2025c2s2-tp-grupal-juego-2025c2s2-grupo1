class VarianteComida {
    const property nombre

    method puntos() 
}

class GustoPokelito inherits VarianteComida {
    const property puntos
}

class VarianteBayalita inherits VarianteComida {
    const property puntos = 500
}

//Gustos de Pokelitos
const frutilla = new GustoPokelito (
    puntos =            150,
    nombre =     "frutilla_"
)

const naranja = new GustoPokelito (
    puntos =            200,
    nombre =      "naranja_"
)

const chocolate = new GustoPokelito (
    puntos =            250, 
    nombre =    "chocolate_"
)

const limon = new GustoPokelito (
    puntos =            100,
    nombre =        "limon_"
)

const dulceDeLeche = new GustoPokelito (
    puntos =            250,
    nombre = "dulceDeLeche_"
)


//Variantes de Bayas
const frambu = new VarianteBayalita ( nombre = "frambu_" )

const grana = new VarianteBayalita  ( nombre = "grana_"  )

const tamate = new VarianteBayalita ( nombre = "tamate_" )

const ziuela = new VarianteBayalita ( nombre = "ziuela_" )

const meloc = new VarianteBayalita  ( nombre = "meloc_"  )
