// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest

enum RateTipResult {
    case low
}

struct RateTip {
    func rate(tip: UInt) -> RateTipResult {
        .low
    }
}

final class RateTipTests: XCTestCase {
    func test_rateTip() {
        typealias TestCase = (tip: UInt, expected: RateTipResult, message: String)
        let tests: [TestCase] = [
            (tip: 5, expected: .low, message: "Tips <= 5 should be rated as low"),
            (tip: 0, expected: .low, message: "Tips <= 5 should be rated as low")            
        ]
        
        let sut = RateTip()
        
        for test in tests {
            let rate = sut.rate(tip: test.tip)
            XCTAssertEqual(rate, test.expected, test.message)
        }
    }
}
