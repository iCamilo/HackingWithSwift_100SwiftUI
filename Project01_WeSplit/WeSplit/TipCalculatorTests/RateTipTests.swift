// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest

enum RateTipResult {
    case low
    case good
    case excellent
}

struct RateTip {
    func rate(tip: UInt) -> RateTipResult {
        switch tip {
        case 0...5:
            return .low
        case 6...20:
            return .good
        default:
            return .excellent
        }
    }
}

final class RateTipTests: XCTestCase {
    func test_rateTip() {
        typealias TestCase = (tip: UInt, expected: RateTipResult, message: String)
        let tests: [TestCase] = [
            (tip: 5, expected: .low, message: "Tips <= 5 should be rated as low"),
            (tip: 0, expected: .low, message: "Tips <= 5 should be rated as low"),
            (tip: 6, expected: .good, message: "Tips > 5 and <= 20 should be rated as good"),
            (tip: 20, expected: .good, message: "Tips > 5 and <= 20 should be rated as good"),
            (tip: 21, expected: .excellent, message: "Tips > 20 should be rated as excellent"),
            (tip: 50, expected: .excellent, message: "Tips > 20 should be rated as excellent")
        ]
        
        let sut = RateTip()
        
        for test in tests {
            let rate = sut.rate(tip: test.tip)
            XCTAssertEqual(rate, test.expected, "\(test.tip)% tip: \(test.message)" )
        }
    }
}
