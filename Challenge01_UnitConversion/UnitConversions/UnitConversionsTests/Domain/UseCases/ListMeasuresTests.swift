//  Created by Ivan Fuertes on 17/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import XCTest
@testable import UnitConversions

class ListMeasuresTests: XCTestCase {
    
    private let sut: ListMeasures = ListMeasuresAdapter()

    func test_listMeasures() {
        // Given
        let expected = ["distance", "mass"]
        
        // When
        let results = sut.execute()
        
        // Then        
        XCTAssertEqual(expected, results.map { $0.description } , "\(expected) should be the listed measures")
    }
    
    func test_forDistanceMeasure_listSupportedUnits() {
        // Given
        let distanceMeasureDescription = "distance"
        let expected = ["meters", "kilometers", "astronomical units"]
        
        // When
        let measures = sut.execute()
        let receivedUnits = units(forMeasureDescription: distanceMeasureDescription, fromMeasures: measures)
                
        // Then
        XCTAssertEqual(receivedUnits, expected, "The supported units for distance measure should be \(expected)")
    }
    
    func test_forMassMeasure_listSupportedUnits() {
        // Given
        let distanceMeasureDescription = "mass"
        let expected = ["grams", "kilograms"]
        
        // When
        let measures = sut.execute()
        let receivedUnits = units(forMeasureDescription: distanceMeasureDescription, fromMeasures: measures)
                
        // Then
        XCTAssertEqual(receivedUnits, expected, "The supported units for mass measure should be \(expected)")
    }
            
}

private extension ListMeasuresTests {
    func units(forMeasureDescription description: String, fromMeasures measures: [Measure]) -> [String]? {
        let measure = measures.filter { $0.description == description }.first
        let units = measure?.units.map { $0.description }
        
        return units
    }
}
