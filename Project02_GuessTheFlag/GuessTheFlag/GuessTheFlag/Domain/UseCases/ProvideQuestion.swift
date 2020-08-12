//  Created by Ivan Fuertes on 16/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import Foundation

protocol ProvideQuestion {    
    func execute() -> Question
}

final class ProvideFlagsQuestionAdapter: ProvideQuestion {
    private var totalOptions: Int
    private var flagsRepository: FlagsRepository

    init(flagsRepository: FlagsRepository, totalOptions: Int) {
        self.flagsRepository = flagsRepository
        self.totalOptions = totalOptions
    }
    
    func execute() -> Question {
        let flags = flagsRepository.retrieve()
        let options = Array(flags.shuffled().prefix(totalOptions))
        let answer = Int.random(in: 0..<totalOptions)
        let question = options[answer]
        
        return Question(question: question, options: options, correctAnswer: answer)
    }
}
