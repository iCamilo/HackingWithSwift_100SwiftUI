//  Created by Ivan Fuertes on 16/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import XCTest
@testable import UnitConversions

class ConverterTests: XCTestCase {
    
    private let sut: Converter = ConverterAdapter()
            

    func testGivenMeters_convertToKilometers_returnKilometers() {
        // Given
        let meters = Double(100)
        let fromUnit = MeterUnit()
        let toUnit = KilometerUnit()
        let expected = Double(0.1)

        // When
        let result = sut.execute(forValue: meters, fromUnit: fromUnit, toUnit: toUnit)

        // Then
        XCTAssertEqual(result, expected, "Converting \(meters) meters should result in \(expected) kilometers")

    }

    func testGivenKilometers_convertToMeters_returnMeters() {
        // Given
        let kilometers = Double(0.1)
        let fromUnit = KilometerUnit()
        let toUnit = MeterUnit()
        let expected = Double(100)

        // When
        let result = sut.execute(forValue: kilometers, fromUnit: fromUnit, toUnit: toUnit)

        // Then
        XCTAssertEqual(expected, result, "\(kilometers) should be \(expected) meters")
    }

    func testGivenMeters_convertToAstronomicalUnits_returnAstronomical() {
        // Given
        let meters = Double(1)
        let fromUnit = MeterUnit()
        let toUnit = AstronomicalUnits()
        let expected = 6.684587122268445e-12

        // When
        let result = sut.execute(forValue: meters, fromUnit: fromUnit, toUnit: toUnit)

        // Then
        XCTAssertEqual(expected, result, "\(meters) meters should be \(expected) astronomical units")
    }

    func testGivenGrams_convertToKilogram_returnKilogram() {
        // Given
        let grams = Double(1)
        let fromUnit = GramUnit()
        let toUnit = KilogramUnit()
        let expected = Double(0.001)

        // When
        let result = sut.execute(forValue: grams, fromUnit: fromUnit, toUnit: toUnit)

        // Then
        XCTAssertEqual(expected, result, "\(grams) grams should be \(expected) kilograms")
    }

    func testGivenGrams_convertToGrams_returnSameValue() {
        // Given
        let grams = Double(1)
        let fromUnit = GramUnit()

        // When
        let result = sut.execute(forValue: grams, fromUnit: fromUnit, toUnit: fromUnit)

        // Then
        XCTAssertEqual(grams, result, "\(grams) grams should be \(grams) pounds")
    }
}
