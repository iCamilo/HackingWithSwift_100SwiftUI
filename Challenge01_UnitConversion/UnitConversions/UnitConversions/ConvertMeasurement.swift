//
//  ConvertMeasurement.swift
//  UnitConversions
//
//  Created by Ivan Fuertes on 16/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

protocol ConvertMeasure {
    associatedtype unit: MeasureUnit

    func execute(from: unit, to: unit, value: Double) -> Double
}

struct ConvertLength: ConvertMeasure {
    typealias unit = LengthUnit
    
    func execute(from: LengthUnit, to: LengthUnit, value: Double) -> Double {
        let fromMeasurement = Measurement(value: value, unit: from.toDimension())
        let toMeasurement = fromMeasurement.converted(to: to.toDimension())
        
        return toMeasurement.value
    }
}

