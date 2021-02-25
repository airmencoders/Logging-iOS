//
//  XCTestCase+FatalError.swift
//  PBLogging
//
//  Created by Pete Hoch on 2/25/21.
//

import XCTest
@testable import Logging

extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil

        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }

        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)

            FatalErrorUtil.restoreFatalError()
        }
    }

    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
