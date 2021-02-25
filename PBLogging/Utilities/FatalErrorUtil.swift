//
//  FatalErrorUtil.swift
//  PBLogging
//
//  Created by Pete Hoch on 2/25/21.
//

import Foundation

// This is a replacement for Swift fatalError so that we can swap out the behavior for UI testing.
func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

struct FatalErrorUtil {

    // The closure reference we can change when we are testing
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure

    // The default swift behavior.
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }

    // Used in Unit tests to change the fatalError behavior.
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }

    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
