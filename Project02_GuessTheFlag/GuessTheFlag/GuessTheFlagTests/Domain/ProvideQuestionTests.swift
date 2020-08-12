//  Created by Ivan Fuertes on 16/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import XCTest
@testable import GuessTheFlag

class ProvideFlagQuestionAdapterTests: XCTestCase {
    
    private var sut: ProvideFlagsQuestionAdapter!
    
    override func setUp() {
        let mockFlagsRepository = MockFlagsRepository(flags: [""])
        self.sut = ProvideFlagsQuestionAdapter(questionsRepository: mockFlagsRepository)
    }
    
    func test_askForAQuestion_receiveAQuestionType() {
        let question = sut.execute()
                
        XCTAssertNotNil(question)
    }
    
    func test_askForQuestion_questioHasAnEnunciate() {
        let question = sut.execute()
                
        XCTAssertFalse(question.question.isEmpty)
    }
    
    func test_askForQuestion_questioHasAtLeastOneOption() {
        let question = sut.execute()
                
        XCTAssertTrue(question.options.count >= 1)
    }
    
    func test_askForQuestion_questioHasACorrectAnswer() {
        let question = sut.execute()
                
        XCTAssertFalse(question.answer.isEmpty)
    }
    
    func test_givenADatasourceWithMoreThanThreeOptions_returnAQuestionWithThreeOptions() {
        let mockFlagsRepository = MockFlagsRepository(flags: ["Spain", "Venezuela", "Etiopia", "Honduras"])
        self.sut = ProvideFlagsQuestionAdapter(questionsRepository: mockFlagsRepository)
        
        let question = sut.execute()

        XCTAssertEqual(question.options.count, 3)
    }

}

class MockFlagsRepository: FlagsRepository {
    private let flags: [String]
    
    init(flags: [String]) {
        self.flags = flags
    }
    
    func retrieve() -> [String] {
        return flags
    }
}
