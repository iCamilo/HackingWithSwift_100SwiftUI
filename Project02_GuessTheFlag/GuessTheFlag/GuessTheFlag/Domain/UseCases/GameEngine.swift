//  Created by Ivan Fuertes on 19/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

class GameEngineAdapter {
    private var totalQuestions: UInt?
    private var trackProgress: TrackProgress
    private var provideQuestion: ProvideQuestion
    private var keepScore: KeepScore
    
    var score: UInt {
        return keepScore.currentScore
    }
    var status: ProgressStatus {
        return trackProgress.status
    }
    var question: Question?
    
    init(trackProgress: TrackProgress,
         provideQuestion: ProvideQuestion,
         keepScore: KeepScore) {
        self.trackProgress = trackProgress
        self.provideQuestion = provideQuestion
        self.keepScore = keepScore
    }
    
    func start(withTotalQuestions totalQuestions: UInt) {
        guard totalQuestions > 0 else {
            return
        }
        
        self.totalQuestions = totalQuestions
        keepScore.restartScore()
        trackProgress.restart()
        
        question = provideQuestion.execute()
    }
    
    func answer(selectedOption option: Int, question: Question) {
        guard trackProgress.status != .finished else {
            return
        }
        
        keepScore.score(question: question, selectedOption: option)
        trackProgress.advance()
        self.question = status == .finished ? nil :  provideQuestion.execute()
    }

}


