//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

protocol KeepScore {
    var currentScore: UInt { get }
    
    func score(question: Question, selectedOption: Int)
    func restartScore()
}

final class KeepScoreAdapter: KeepScore {
    private(set) var currentScore: UInt = 0
    
    func score(question: Question, selectedOption: Int) {
        let isAnswerCorrect = question.correctAnswer == selectedOption
        self.currentScore += isAnswerCorrect ? 1 : 0
    }
    
    func restartScore() {
        currentScore = 0
    }
}
