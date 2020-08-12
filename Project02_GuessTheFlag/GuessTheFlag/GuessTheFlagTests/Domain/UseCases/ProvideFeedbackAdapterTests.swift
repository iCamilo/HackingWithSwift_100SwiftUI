//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation
import XCTest
@testable import GuessTheFlag

final class ProvideFeedbackAdapterTests: XCTestCase {
    
    func test_correctAnswer_askFeedBack_returnsNoFeedback() {
        let sut = ProvideFeedbackAdapter()
        let correctOption = 1
        let question = MockQuestionFactory.makeQuestion(withCorrectAnswer: correctOption)
        
        let feedback = sut.execute(forQuestion: question, andSelectedOption: correctOption)
        
        XCTAssertNil(feedback)
    }
        
    func test_incorrectAnswer_askFeedBack_feedbackProvideExpectedVSSelected() {
        let sut = ProvideFeedbackAdapter()
        let correctOption = 1
        let selectedOption = 0
        let question = MockQuestionFactory.makeQuestion(withCorrectAnswer: correctOption)

        guard let feedback = sut.execute(forQuestion: question, andSelectedOption: selectedOption) else {
            XCTFail("For an incorrect answer, a feedback should be provided")
            return
        }

        XCTAssertEqual(feedback.selectedAnswer, "A1")
        XCTAssertEqual(feedback.expectedAnswer, "A2")
    }
}
