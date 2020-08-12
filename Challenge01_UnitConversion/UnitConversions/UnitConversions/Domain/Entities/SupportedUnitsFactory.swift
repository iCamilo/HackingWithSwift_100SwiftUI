//  Created by Ivan Fuertes on 14/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

struct SupportedDistanceUnitsFactory {
    static func create() -> [MeasureUnit] {
        return [MeterUnit(), KilometerUnit(), AstronomicalUnits()]
    }
}

struct SupportedMassUnitsFactory {
    static func create() -> [MeasureUnit] {
        return [GramUnit(), KilogramUnit()]
    }
}

