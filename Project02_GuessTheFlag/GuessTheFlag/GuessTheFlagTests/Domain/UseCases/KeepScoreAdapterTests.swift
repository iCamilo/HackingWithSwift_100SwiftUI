//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation
import XCTest
@testable import GuessTheFlag

final class KeepScoreAdapterTests: XCTestCase {
    
    func test_initScorer_askForScore_scoreReturnsZero() {
        let sut = KeepScoreAdapter()
        
        XCTAssertEqual(sut.currentScore, 0)
    }
    
    func test_oneIncorrectAnswerAndOneCorrectAnswer_askForScore_scoreReturnsOne() {
        let sut = KeepScoreAdapter()
        let correctOption = 0
        let incorrectOption = 1
        let question = MockQuestionFactory.makeQuestion(withCorrectAnswer: correctOption)
            
        sut.score(question: question, selectedOption: incorrectOption)
        sut.score(question: question, selectedOption: correctOption)
        
        XCTAssertEqual(sut.currentScore, 1)
    }
    
    func test_allIncorrectAnswers_askForScore_scoreReturnsZero() {
        let sut = KeepScoreAdapter()
        let question = MockQuestionFactory.makeQuestion(withCorrectAnswer: 0)
        let selectedOption = 1
            
        sut.score(question: question, selectedOption: selectedOption)
        sut.score(question: question, selectedOption: selectedOption)
        
        XCTAssertEqual(sut.currentScore, 0)
    }
    
    func test_allTwoCorrectAnswers_askForScore_returnsTwo() {
        let sut = KeepScoreAdapter()
        let correctOption = 0
        let question = MockQuestionFactory.makeQuestion(withCorrectAnswer: correctOption)
            
        sut.score(question: question, selectedOption: correctOption)
        sut.score(question: question, selectedOption: correctOption)
        
        XCTAssertEqual(sut.currentScore, 2)
    }
    
    func test_scoreIsNotZero_restartScore_scoreReturnsZero() {
        let sut = KeepScoreAdapter()
        let correctOption = 0
        let question = MockQuestionFactory.makeQuestion(withCorrectAnswer: correctOption)
        sut.score(question: question, selectedOption: correctOption)
        let initialScore = sut.currentScore
        
        sut.restartScore()
        
        XCTAssertEqual(initialScore, 1)
        XCTAssertEqual(sut.currentScore, 0)
    }
    
}
