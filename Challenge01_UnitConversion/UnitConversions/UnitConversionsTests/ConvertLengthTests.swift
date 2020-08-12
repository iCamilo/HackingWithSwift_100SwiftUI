//
//  ConvertLengthTests.swift
//  UnitConversionsTests
//
//  Created by Ivan Fuertes on 16/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import XCTest
@testable import UnitConversions

class ConverterTests: XCTestCase {
    
    private let sut: Converter = ConverterAdapter()
        
    func testGivenMeters_convertToKilometers_returnKilometers() {
        // Given
        let measureIdentifier = "length"
        let meters = Double(100)
        let fromUnit = "meter"
        let toUnit = "kilometer"
        let expected = Double(0.1)
        
        // When
        let result = sut.execute(forValue: meters, forMeasure: measureIdentifier, fromUnit: fromUnit, toUnit: toUnit)
        
        // Then
        XCTAssertEqual(result, expected, "\(meters) meters should be \(result) kilometers")
        
    }
    
    func testGivenKilometers_convertToMeters_returnMeters() {
        // Given
        let measureIdentifier = "length"
        let kilometers = Double(0.1)
        let fromUnit = "kilometer"
        let toUnit = "meter"
        let expected = Double(100)

        // When
        let result = sut.execute(forValue: kilometers, forMeasure: measureIdentifier, fromUnit: fromUnit, toUnit: toUnit)

        // Then
        XCTAssertEqual(expected, result, "\(kilometers) should be \(expected) meters")
    }

    func testGivenMeters_convertToAstronomicalUnits_returnAstronomical() {
        // Given
        let measureIdentifier = "length"
        let meters = Double(1)
        let fromUnit = "meter"
        let toUnit = "astronomical"
        let expected = 6.684587122268445e-12

        // When
        let result = sut.execute(forValue: meters, forMeasure: measureIdentifier, fromUnit: fromUnit, toUnit: toUnit)

        // Then
        XCTAssertEqual(expected, result, "\(meters) meters should be \(result) astronomical units")
    }

}
