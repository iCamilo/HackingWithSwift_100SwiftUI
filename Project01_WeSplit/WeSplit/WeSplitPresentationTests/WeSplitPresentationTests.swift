// WeSplit
// Copyright ©️ 2024 Iván Camilo Fuertes. All rights reserved.


import XCTest
@testable import WeSplitPresentation

struct WeSplitViewModel {
    var checkTotal: String = ""
    var showTotal: Bool {
        Double(checkTotal) != nil
    }
}

final class WeSplitPresentationTests: XCTestCase {
    
    func test_showTotalOnlyIfCheckTotalIsANumber() {
        var sut = WeSplitViewModel()
        
        sut.checkTotal = ""
        XCTAssertFalse(sut.showTotal)
        
        sut.checkTotal = "invalid"
        XCTAssertFalse(sut.showTotal)
        
        sut.checkTotal = "100"
        XCTAssertTrue(sut.showTotal)
    }

}
