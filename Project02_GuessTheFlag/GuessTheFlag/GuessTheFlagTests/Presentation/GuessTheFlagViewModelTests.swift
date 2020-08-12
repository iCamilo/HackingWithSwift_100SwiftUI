//  Created by Ivan Fuertes on 19/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import XCTest
@testable import GuessTheFlag

final class GuessTheFlagViewModelTests: XCTestCase {
            
    func test_startGame_thereIsAQuestionAvailable() {
        let totalQuestions: UInt = 1
        let sut = makeSUT(totalQuestions: totalQuestions)

        sut.startGame()
        
        XCTAssertNotNil(sut.currentQuestion)
    }
    
    func test_startGame_scoreIsZeroAndStatusIsInProgress() {
        let totalQuestions: UInt = 1
        let sut = makeSUT(totalQuestions: totalQuestions)

        sut.startGame()
        
        XCTAssertEqual(sut.currentScore, "0 / 1")
        XCTAssertEqual(sut.currentStatus, "1 / 1")
    }
    
    func test_startGameWithOneQuestion_answerTheQuestion_showGameOver() {
        let totalQuestions: UInt = 1
        let selectedOption = 0
        let sut = makeSUT(totalQuestions: totalQuestions)
        sut.startGame()
        
        sut.answer(withOption: selectedOption)
        
        XCTAssertEqual(sut.currentStatus, "1 / 1")
        XCTAssertTrue(sut.showGameOver)
    }
    
    func test_startGameWithTwoQuestions_answerFirstQuestion_doNotShowGameOver() {
        let totalQuestions: UInt = 2
        let selectedOption = 0
        let sut = makeSUT(totalQuestions: totalQuestions)
        sut.startGame()
        
        sut.answer(withOption: selectedOption)
        
        XCTAssertEqual(sut.currentStatus, "2 / 2")
        XCTAssertFalse(sut.showGameOver)
    }
    
    func test_startGameWithTwoQuestions_answerBothQuestions_showGameOver() {
        let totalQuestions: UInt = 2
        let selectedOption = 0
        let sut = makeSUT(totalQuestions: totalQuestions)
        sut.startGame()
        
        sut.answer(withOption: selectedOption)
        sut.answer(withOption: selectedOption)
        
        XCTAssertEqual(sut.currentStatus, "2 / 2")
        XCTAssertTrue(sut.showGameOver)
    }
    
    func test_startGameWithOneQuestion_answerTheQuestionCorrectly_scoreIsOne() {
        let totalQuestions: UInt = 1
        let selectedOption = MockGameEngine.correctAnswerOption
        let sut = makeSUT(totalQuestions: totalQuestions)
        sut.startGame()
        
        sut.answer(withOption: selectedOption)
        
        XCTAssertEqual(sut.currentScore, "1 / 1")
    }
    
    func test_startGameWithTwoQuestions_answerOneCorrectly_scoreIsOne() {
        let totalQuestions: UInt = 2
        let sut = makeSUT(totalQuestions: totalQuestions)
        sut.startGame()
        
        sut.answer(withOption: MockGameEngine.correctAnswerOption)
        sut.answer(withOption: MockGameEngine.incorrectAnswerOption)
                
        XCTAssertEqual(sut.currentScore, "1 / 2")
    }
}

private extension GuessTheFlagViewModelTests {
    func makeSUT(totalQuestions: UInt) -> GuessTheFlagViewModel {
        let gameEngine = MockGameEngine(totalQuestions: totalQuestions)
        
        return GuessTheFlagViewModel(gameEngine: gameEngine)
    }
}

private final class MockGameEngine: GameEngine {
    
    static let correctAnswerOption = 0
    static let incorrectAnswerOption = 1
    
    private(set) var totalQuestions: UInt
    private(set) var score: UInt = 0
    private(set) var status: ProgressStatus = .finished
    private(set) var currentFeedback: Feedback?
    private(set) var question: Question?
        
    var currentStep: UInt = 1
    
    init(totalQuestions: UInt) {
        self.totalQuestions = totalQuestions
    }
    
    func start() {
        question = MockQuestionFactory.makeQuestion(withCorrectAnswer: MockGameEngine.correctAnswerOption)
        status = ProgressStatus.inProgress(currentStep: currentStep, totalSteps: totalQuestions)
    }
    
    func answer(selectedOption option: Int, question: Question) {
        guard status != .finished else {
            return
        }
        
        currentStep += 1
        score = option == 0 ? score + 1 : score + 0
        status = currentStep > totalQuestions ? .finished : .inProgress(currentStep: currentStep, totalSteps: totalQuestions)
        self.question = status != .finished ? MockQuestionFactory.makeQuestion(withCorrectAnswer: MockGameEngine.correctAnswerOption) : nil
    }
    
    
}
