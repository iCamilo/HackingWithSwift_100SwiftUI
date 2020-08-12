//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

typealias Feedback = (expectedAnswer: String, selectedAnswer: String)

protocol ProvideFeedback {
    func execute(forQuestion question: Question, andSelectedOption option: Int) -> Feedback?
}

final class ProvideFeedbackAdapter: ProvideFeedback {    
    
    func execute(forQuestion question: Question, andSelectedOption option: Int) -> Feedback? {
        guard question.correctAnswer != option else {
            return nil
        }
        
        let selectedAnswer = question.options[option]
        let expectedAnswer = question.options[question.correctAnswer]
                
        return (expectedAnswer: expectedAnswer, selectedAnswer: selectedAnswer)
    }
    
}
