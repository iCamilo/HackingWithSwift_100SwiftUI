//  Created by Ivan Fuertes on 16/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import XCTest
@testable import GuessTheFlag

class ProvideFlagQuestionAdapterTests: XCTestCase {
    
    private let flags = ["Spain", "Venezuela", "Etiopia", "Honduras", "Peru", "Bolivia", "Ecuador", "Brasil", "Argentina"]
    private var sut: ProvideFlagsQuestionAdapter!
                                        
    func test_givenFiveOptionsAsInput_askForQuestion_returnAQuestionWithFiveShuffledOptions() {
        // GIVEN
        let totalOptions = 5
        let firstFlags = Array(flags.prefix(5))
        makeSUTFromFlagsList(flags, totalOptions: totalOptions)
        
        // WHEN
        let question = sut.execute()

        // THEN
        XCTAssertEqual(question.options.count, totalOptions, "A question should provide the total options requested")
        XCTAssertTrue(question.options != firstFlags, "Options should be shuffled and not always be the same first options from the repository")
    }
    
    func test_givenARepositoryWithMultipleFlags_askForQuestion_returnAQuestionFromTheAvailableOptions() {
        // GIVEN
        makeSUTFromFlagsList(flags)
        
        // WHEN
        let question = sut.execute()

        // THEN
        XCTAssertEqual(question.options.filter { $0 == question.question }.count , 1 , "The question should be part of the options")
    }
    
    func test_givenARepositoryWithMultipleFlags_askForQuestion_returnAnAnswerThatIsEqualToTheQuestion() {
        // GIVEN
        makeSUTFromFlagsList(flags)
        
        // WHEN
        let question = sut.execute()
        let correctAnswer = question.options[question.correctAnswer]

        // THEN
        XCTAssertEqual(question.question, correctAnswer, "The correct answer from the options should be the same as the original question")
    }
}

private extension ProvideFlagQuestionAdapterTests {
    func makeSUTFromFlagsList(_ flags: [String], totalOptions: Int = 3) {
        let mockFlagsRepository = MockFlagsRepository(flags: flags)
        self.sut = ProvideFlagsQuestionAdapter(flagsRepository: mockFlagsRepository, totalOptions:totalOptions)
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
