//  Created by Ivan Fuertes on 20/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

class CompositionRoot {
    static func guessTheFlagView() -> GuessTheFlagView {        
        return GuessTheFlagComponentsBuilder().makeGuessTheFlagView()
    }
}

private class GuessTheFlagComponentsBuilder {
    private let totalQuestions: UInt = 5
    private let questionTotalOptions = 3
            
    private func makeFlagsRepository() -> FlagsRepository {
        return InMemoryFlagsRepository()
    }
    
    private func makeGameEngine() -> GameEngine {
        let trackProgress = TrackProgressAdapter(totalSteps: totalQuestions)
        let provideQuestion = ProvideFlagsQuestionAdapter(flagsRepository: makeFlagsRepository(), totalOptions: questionTotalOptions)
        let keepScore = KeepScoreAdapter()
        let provideFeedback = ProvideFeedbackAdapter()
        
        return GameEngineAdapter(trackProgress: trackProgress,
                                 provideQuestion: provideQuestion,
                                 keepScore: keepScore,
                                 provideFeedback: provideFeedback,
                                 totalQuestions: totalQuestions)
    }
    
    func makeGuessTheFlagView() -> GuessTheFlagView {
        let viewModel = GuessTheFlagViewModel(gameEngine: makeGameEngine())
        
        return GuessTheFlagView(viewModel: viewModel)
    }
}
