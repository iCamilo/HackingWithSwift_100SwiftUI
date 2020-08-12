//  Created by Ivan Fuertes on 19/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

protocol GameEngine {
    var totalQuestions: UInt { get }
    var score: UInt { get }
    var status: ProgressStatus { get }
    var currentFeedback: Feedback? { get }
    var question: Question? { get }
    
    func start()
    func answer(selectedOption option: Int, question: Question)
}

class GameEngineAdapter: GameEngine {
    private(set) var totalQuestions: UInt
    private var trackProgress: TrackProgress
    private var provideQuestion: ProvideQuestion
    private var keepScore: KeepScore
    private var provideFeedback: ProvideFeedback

    var score: UInt {
        return keepScore.currentScore
    }
    var status: ProgressStatus {
        return trackProgress.status
    }
    private(set) var currentFeedback: Feedback?
    private(set) var question: Question?
    
    init(trackProgress: TrackProgress,
         provideQuestion: ProvideQuestion,
         keepScore: KeepScore,
         provideFeedback: ProvideFeedback,
         totalQuestions: UInt) {
        self.trackProgress = trackProgress
        self.provideQuestion = provideQuestion
        self.keepScore = keepScore
        self.provideFeedback = provideFeedback
        self.totalQuestions = totalQuestions
    }
    
    func start() {
        guard totalQuestions > 0 else {
            return
        }
                
        keepScore.restartScore()
        trackProgress.restart()
        
        question = provideQuestion.execute()
    }
    
    func answer(selectedOption option: Int, question: Question) {
        guard trackProgress.status != .finished else {
            return
        }
        
        keepScore.score(question: question, selectedOption: option)
        self.currentFeedback = provideFeedback.execute(forQuestion: question, andSelectedOption: option)
        trackProgress.advance()
        self.question = status == .finished ? nil :  provideQuestion.execute()
    }

}


