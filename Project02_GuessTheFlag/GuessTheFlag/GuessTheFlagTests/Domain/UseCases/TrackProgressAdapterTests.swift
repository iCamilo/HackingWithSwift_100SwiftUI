//  Created by Ivan Fuertes on 18/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.

import XCTest
@testable import GuessTheFlag

final class TrackProgressAdapterTests: XCTestCase {
    
    func test_createWithNoQuestions_askStatus_statusIsFinished() {
        let totalQuestions: UInt = 0
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        
        let status = sut.status
        
        XCTAssertEqual(status, ProgressStatus.finished)
    }
    
    func test_createdWithFiveQuestion_askStatus_statusIsInProgressOneOfFive() {
        let totalQuestions: UInt = 5
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        
        let status = sut.status
        
        XCTAssertEqual(status, ProgressStatus.inProgress(currentStep: 1 ,totalSteps: totalQuestions))
    }
    
    func test_createdWithOneQuestions_updateStatus_statusIsFinished() {
        let totalQuestions: UInt = 1
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        let initialStatus = sut.status
        
        let _ = sut.advance()
        let currentStatus = sut.status
        
        XCTAssertEqual(initialStatus, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
        XCTAssertEqual(currentStatus, ProgressStatus.finished)
    }
    
    func test_createdWithTwoQuestions_updateStatusOnce_statusIsInProgressTwoOfTwo() {
        let totalQuestions: UInt = 2
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        let initialStatus = sut.status

        sut.advance()
        let currentStatus = sut.status

        XCTAssertEqual(initialStatus, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
        XCTAssertEqual(currentStatus, ProgressStatus.inProgress(currentStep: 2, totalSteps: totalQuestions))
        
    }
    
    func test_createdWithFiveQuestions_updateStatusTwiceTimes_statusIsInProgressThreeOfFive() {
        let totalQuestions: UInt = 5
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        let initialStatus = sut.status
        
        sut.advance()
        sut.advance()
        let currentStatus = sut.status

        XCTAssertEqual(initialStatus, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
        XCTAssertEqual(currentStatus, ProgressStatus.inProgress(currentStep: 3, totalSteps: totalQuestions))
        
    }

    func test_createdWithTwoQuestions_updateStatusTwice_statusIsFinished() {
        let totalQuestions: UInt = 2
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        let initialStatus = sut.status

        sut.advance()
        sut.advance()
        let currentStatus = sut.status

        XCTAssertEqual(initialStatus, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
        XCTAssertEqual(currentStatus, ProgressStatus.finished)
    }

    func test_createdWithOneQuestions_updateStatusTwice_statusIsFinished() {
        let totalQuestions: UInt = 1
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)

        sut.advance()
        sut.advance()

        XCTAssertEqual(sut.status, ProgressStatus.finished)
    }

    func test_createdWithNoQuestions_updateStatusTwice_statusIsFinished() {
        let totalQuestions: UInt = 0
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)

        sut.advance()
        sut.advance()

        XCTAssertEqual(sut.status, ProgressStatus.finished)
    }
    
    func test_inFinishState_restartStatus_statusIsInProgress() {
        let totalQuestions: UInt = 1
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        sut.advance()
        
        sut.restart()

        XCTAssertEqual(sut.status, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
        
    }
    
    func test_inProgressStateTwoOfFive_restartStatus_statusIsInProgressOneOfFive() {
        let totalQuestions: UInt = 5
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        sut.advance()
        let currentStatus = sut.status
        
        sut.restart()
        
        XCTAssertEqual(currentStatus, ProgressStatus.inProgress(currentStep: 2, totalSteps: totalQuestions))
        XCTAssertEqual(sut.status, ProgressStatus.inProgress(currentStep: 1, totalSteps: totalQuestions))
    }
    
    func test_createWithNoQuestions_restartStatus_statusIsFinished() {
        let totalQuestions: UInt = 0
        let sut = TrackProgressAdapter(totalSteps: totalQuestions)
        sut.advance()
        
        sut.restart()
        
        XCTAssertEqual(sut.status, ProgressStatus.finished)
    }
    
}


