//  Created by Ivan Fuertes on 23/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

protocol Measure: CustomStringConvertible {
    var units: [MeasureUnit] { get }
}

struct Mass: Measure {
    var units = SupportedMassUnitsFactory.create()
    var description: String {
        return "mass"
    }
}

struct Distance: Measure {
    var units = SupportedDistanceUnitsFactory.create()
    var description = "distance"
}


