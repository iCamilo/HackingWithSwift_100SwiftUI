//  Created by Ivan Fuertes on 19/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

protocol GuessTheFlagViewModelInterface {
    var currentQuestion: String? { get }
    var currentScore: String? { get }
    var currentStatus: String? { get }
    var showGameOver: Bool { get }
    
    func startGame()
    func answer(withOption option: Int)
}

final class GuessTheFlagViewModelAdapter: ObservableObject, GuessTheFlagViewModelInterface {
    private let gameEngine: GameEngine
    
    @Published private(set) var currentQuestion: String?
    @Published private(set) var currentScore: String?
    @Published private(set) var currentStatus: String?
    @Published private(set) var showGameOver: Bool = false
            
    init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }
            
    func startGame() {
        gameEngine.start()
        
        formatCurrentQuestion()
        formatCurrentScore()
        formatCurrentStatus()
    }
    
    func answer(withOption option: Int) {
        guard let question = gameEngine.question else {
            return
        }
        
        gameEngine.answer(selectedOption: option, question: question)
                
        showGameOver = gameEngine.status == .finished
        formatCurrentQuestion()
        formatCurrentScore()
    }
    
}

private extension GuessTheFlagViewModelAdapter {
    func formatCurrentQuestion() {
        self.currentQuestion = gameEngine.question?.question
    }
    
    func formatCurrentScore() {
        self.currentScore = "\(gameEngine.score) / \(gameEngine.totalQuestions)"
        formatCurrentStatus()
    }
    
    func formatCurrentStatus() {
        if case let ProgressStatus.inProgress(currentStep, totalSteps) = gameEngine.status {
            self.currentStatus = "\(currentStep) / \(totalSteps)"
        }
    }
}
