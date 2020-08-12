//  Created by Ivan Fuertes on 16/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

protocol Converter {
    func execute(forValue value: Double, fromUnit from: MeasureUnit, toUnit to: MeasureUnit) -> Double
}

struct ConverterAdapter: Converter {
    
    func execute(forValue value: Double, fromUnit from: MeasureUnit, toUnit to: MeasureUnit) -> Double {
        let fromMeasurement = Measurement(value: value, unit: from.dimension)
        let toMeasurement = fromMeasurement.converted(to: to.dimension)
        
        return toMeasurement.value
    }
}
