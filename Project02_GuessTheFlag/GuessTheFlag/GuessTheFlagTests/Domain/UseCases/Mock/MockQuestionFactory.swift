//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation
@testable import GuessTheFlag

final class MockQuestionFactory {
    
    static func makeQuestion(withCorrectAnswer answer: Int) -> Question {
        return Question(question: "Q1", options: ["A1", "A2"], correctAnswer: answer)
    }    
}
