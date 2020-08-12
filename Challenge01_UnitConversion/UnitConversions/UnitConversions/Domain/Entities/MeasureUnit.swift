//  Created by Ivan Fuertes on 14/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

protocol MeasureUnit: CustomStringConvertible {
    var dimension: Dimension { get }
    var description: String { get }
}

struct GramUnit: MeasureUnit {
    var dimension: Dimension = UnitMass.grams
    var description: String = "grams"
}

struct KilogramUnit: MeasureUnit {
    var dimension: Dimension = UnitMass.kilograms
    var description: String = "kilograms"
}

struct KilometerUnit: MeasureUnit {
    var dimension: Dimension = UnitLength.kilometers
    var description: String = "kilometers"
}

struct MeterUnit: MeasureUnit {
    var dimension: Dimension = UnitLength.meters
    var description: String = "meters"
}

struct AstronomicalUnits: MeasureUnit {
    var dimension: Dimension = UnitLength.astronomicalUnits
    var description: String = "astronomical units"
}
