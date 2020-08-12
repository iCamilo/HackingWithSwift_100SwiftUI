//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import Foundation

enum ProgressStatus: Equatable {
    case inProgress(currentStep: UInt, totalSteps: UInt)
    case finished
}

protocol TrackProgress {
    var status: ProgressStatus { get }
    
    func advance()
    func restart()
}

final class TrackProgressAdapter: TrackProgress {
    private let totalSteps: UInt
    private var currentStep: UInt = 1
    
    var status: ProgressStatus {
        if totalSteps == 0 {
            return .finished
        }
        
        return currentStep > totalSteps ? .finished : .inProgress(currentStep: currentStep, totalSteps: totalSteps)
    }
    
    init(totalSteps: UInt) {
        self.totalSteps = totalSteps
    }
    
    func advance() {
        guard status != .finished else {
            return
        }
        
        currentStep += 1
    }
    
    func restart() {
        currentStep = 1
    }
}
