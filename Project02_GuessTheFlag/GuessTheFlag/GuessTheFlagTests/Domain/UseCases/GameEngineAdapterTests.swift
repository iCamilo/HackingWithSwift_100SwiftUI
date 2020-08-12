//  Created by Ivan Fuertes on 19/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import XCTest
@testable import GuessTheFlag

final class GameEngineAdapterTests: XCTestCase {
    
    func test_startGameWithNoQuestions_thereIsNotCurrentQuestion() {
        let totalQuestions: UInt = 0
        let sut = makeSUT(totalQuestions: totalQuestions)
        
        sut.start()
        
        XCTAssertNil(sut.question)
    }
    
    func test_startGameWithTwoQuestions_scoreIsZeroAndCurrentProgressStatusIsInProgressOneOfTwo() {
        let totalQuestions: UInt = 2
        let sut = makeSUT(totalQuestions: totalQuestions)
        
        sut.start()
        
        XCTAssertEqual(sut.status, ProgressStatus.inProgress(currentStep: 1, totalSteps: 2))
        XCTAssertEqual(sut.score, 0)
    }
                    
    func test_startGameWithNoQuestions_scoreIsZeroAndCurrentProgressStatusIsFinished() {
        let totalQuestions: UInt = 0
        let sut = makeSUT(totalQuestions: totalQuestions)
        
        sut.start()
        
        XCTAssertEqual(sut.status, ProgressStatus.finished)
        XCTAssertEqual(sut.score, 0)
    }
        
    func test_startGameWithOneQuestion_answerTheQuestionIncorrectly_scoreIsZeroAndProgressIsFinished() {
        let totalQuestions: UInt = 1
        let sut = makeSUTAndStartIt(totalQuestions: totalQuestions)
        
        let question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.incorrectOption, question: question)

        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.status, .finished)
    }
    
    func test_startGameWithOneQuestion_answerTheQuestionCorrectly_scoreIsOneAndProgressIsFinished() {
        let totalQuestions: UInt = 1
        let sut = makeSUTAndStartIt(totalQuestions: totalQuestions)

        let question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)

        XCTAssertEqual(sut.score, 1)
        XCTAssertEqual(sut.status, .finished)
    }
    
    func test_startGameWithOneQuestion_answerTheQuestion_thereIsNotNewQuestionToContinue() {
        let totalQuestions: UInt = 1
        let sut = makeSUTAndStartIt(totalQuestions: totalQuestions)
        
        let question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)

        XCTAssertNil(sut.question)
    }
                
    func test_startGameWithTwoQuestions_answerFirstCorrectly_scoreIsOneAndStatusIsInProgressTwoOfTwo() {
        let totalQuestions: UInt = 2
        let sut = makeSUTAndStartIt(totalQuestions: totalQuestions)
        
        let question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)
        
        XCTAssertEqual(sut.score, 1)
        XCTAssertEqual(sut.status, ProgressStatus.inProgress(currentStep: 2, totalSteps: 2))
    }
    
    func test_startGameWithTwoQuestions_answerOneOfTheTwoCorrectly_scoreIsOneAndStatusIsFinished() {
        let totalQuestions: UInt = 2
        let sut = makeSUTAndStartIt(totalQuestions: totalQuestions)
        
        var question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)
        question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.incorrectOption, question: question)
        
        XCTAssertEqual(sut.score, 1)
        XCTAssertEqual(sut.status, ProgressStatus.finished)
    }
    
    func test_startGameWithTwoQuestions_answerBothCorrectly_scoreIsTwoAndStatusIsFinished() {
        let totalQuestions: UInt = 2
        let sut = makeSUTAndStartIt(totalQuestions:totalQuestions)
        
        var question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)
        question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)
        
        XCTAssertEqual(sut.score, 2)
        XCTAssertEqual(sut.status, ProgressStatus.finished)
    }
    
    func test_startGameWithTwoQuestions_answerBothIncorrectly_scoreIsZeroAndStatusIsFinished() {
        let totalQuestions: UInt = 2
        let sut = makeSUTAndStartIt(totalQuestions: totalQuestions)
        
        var question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.incorrectOption, question: question)
        question = sut.question!
        sut.answer(selectedOption: MockProvideQuestion.incorrectOption, question: question)
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.status, ProgressStatus.finished)
    }
    
    func test_gameIsFinished_answerAQuestion_scoreAndStatusRemainTheSameAndThereIsNoANewQuestionAvailable() {
        let totalQuestions: UInt = 1
        let sut = SUTInFinishedState(totalQuestions: totalQuestions)
        let previousScore = sut.score
        let previousStatus = sut.status
        
        let newQuestion = MockProvideQuestion().execute()
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: newQuestion)
        
        XCTAssertNil(sut.question)
        XCTAssertEqual(sut.score, previousScore)
        XCTAssertEqual(sut.status, previousStatus)
    }
    
    func test_gameIsFinished_startGameAgain_scoreIsZeroAndStatusIsInProgressAndThereIsANewQuestionAvailable() {
        let totalQuestions: UInt = 4
        let sut = SUTInFinishedState (totalQuestions: totalQuestions)
                
        sut.start()
        
        XCTAssertNotNil(sut.question)
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.status, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
    }
    
    func test_gameWithOneQuestion_askQuestionIncorrectly_thereIsAnAnswerFeedback() {
        let expectedFeedback: Feedback = (expectedAnswer: "A1", selectedAnswer: "A2")
        let sut = makeSUT(totalQuestions: 1)
        sut.start()
                
        sut.answer(selectedOption: MockProvideQuestion.incorrectOption, question: sut.question!)
        
        XCTAssertEqual(sut.currentFeedback?.expectedAnswer, expectedFeedback.expectedAnswer)
        XCTAssertEqual(sut.currentFeedback?.selectedAnswer, expectedFeedback.selectedAnswer)
    }
    
    func test_gameWithOneQuestion_askQuestionCcorrectly_noAnswerFeedback() {
        let sut = makeSUT(totalQuestions: 1)
        sut.start()
                
        sut.answer(selectedOption: MockProvideQuestion.correctOption, question: sut.question!)
        
        XCTAssertNil(sut.currentFeedback)
    }
}


private extension GameEngineAdapterTests {
    func makeSUT(totalQuestions: UInt) -> GameEngineAdapter {
        let trackProgress = TrackProgressAdapter(totalSteps: totalQuestions)
        let provideQuestion = MockProvideQuestion()
        let keepScore = KeepScoreAdapter()
        let provideFeedback = ProvideFeedbackAdapter()
        
        return GameEngineAdapter(trackProgress: trackProgress,
                          provideQuestion: provideQuestion,
                          keepScore: keepScore,
                          provideFeedback: provideFeedback,
                          totalQuestions: totalQuestions)
    }
    
    func SUTInFinishedState(totalQuestions: UInt) -> GameEngineAdapter {
        let sut = makeSUT(totalQuestions: totalQuestions)
        
        sut.start()
        let question = sut.question!
        
        for _ in 1...totalQuestions {
            sut.answer(selectedOption: MockProvideQuestion.correctOption, question: question)
        }
        
        if sut.status != .finished {
            XCTFail("SUT should be in finished state")
        }
        
        return sut
    }
    
    func makeSUTAndStartIt(totalQuestions: UInt) -> GameEngineAdapter {
        let sut = makeSUT(totalQuestions: totalQuestions)
        sut.start()
        
        return sut
    }
        
}

final class MockProvideQuestion: ProvideQuestion {
    static let correctOption = 0
    static let incorrectOption = 1
    
    func execute() -> Question {
        return Question(question: "Q1", options: ["A1", "A2"], correctAnswer: MockProvideQuestion.correctOption)
    }
}
