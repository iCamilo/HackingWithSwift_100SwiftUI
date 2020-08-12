//  Created by Ivan Fuertes on 19/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

final class GuessTheFlagViewModel: ObservableObject {
    private let showFeedbackInSeconds: TimeInterval = 1
    private let gameEngine: GameEngine
    
    @Published private(set) var currentQuestion: String = ""
    @Published var currentOptions: [String] = []
    @Published private(set) var currentScore: String = ""
    @Published private(set) var currentStatus: String = ""
    @Published var showGameOver: Bool = false
    @Published var currentFeedback: String = ""
            
    init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }
            
    func startGame() {
        gameEngine.start()
        
        formatCurrentQuestionAndOptions()
        formatCurrentScore()
        formatCurrentStatus()
    }
    
    func answer(withOption option: Int) {
        guard let question = gameEngine.question else {
            return
        }
                
        gameEngine.answer(selectedOption: option, question: question)
        
        showCurrentFeedback(forSeconds: showFeedbackInSeconds) {
            self.showGameOver = self.gameEngine.status == .finished
            self.formatCurrentQuestionAndOptions()
            self.formatCurrentScore()
            self.formatCurrentStatus()
        }
    }
    
}

private extension GuessTheFlagViewModel {
    func formatCurrentQuestionAndOptions() {
        guard let question = gameEngine.question else {
            return
        }
        
        self.currentQuestion = question.question
        self.currentOptions = question.options
    }
    
    func formatCurrentScore() {
        self.currentScore = "\(gameEngine.score) / \(gameEngine.totalQuestions)"
    }
    
    func formatCurrentStatus() {
        if case let ProgressStatus.inProgress(currentStep, totalSteps) = gameEngine.status {
            self.currentStatus = "\(currentStep) / \(totalSteps)"
        }
    }
    
    func showCurrentFeedback(forSeconds seconds: TimeInterval, completion: @escaping ()-> Void) {
        guard let feedback = gameEngine.currentFeedback else {
            self.currentFeedback = ""
            completion()
            
            return
        }
                        
        currentFeedback = "🤨🤔 That is the \(feedback.selectedAnswer) flag, not the \(feedback.expectedAnswer) flag"
                
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            DispatchQueue.main.async {
                self.currentFeedback = ""
                completion()
            }
        }
    }

}

