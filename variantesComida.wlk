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
const gustoFrutilla = new GustoPokelito (
    puntos =            150,
    nombre =     "frutilla_"
)

const gustoNaranja = new GustoPokelito (
    puntos =            200,
    nombre =      "naranja_"
)

const gustoChocolate = new GustoPokelito (
    puntos =            250, 
    nombre =    "chocolate_"
)

const gustoLimon = new GustoPokelito (
    puntos =            100,
    nombre =        "limon_"
)

const gustoDulceDeLeche = new GustoPokelito (
    puntos =            250,
    nombre = "dulceDeLeche_"
)


//Variantes de Bayas
const varianteFrambu = new VarianteBayalita ( nombre = "frambu_" )

const varianteGrana = new VarianteBayalita  ( nombre = "grana_"  )

const varianteTamate = new VarianteBayalita ( nombre = "tamate_" )

const varianteZiuela = new VarianteBayalita ( nombre = "ziuela_" )

const varianteMeloc = new VarianteBayalita  ( nombre = "meloc_"  )
