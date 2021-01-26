//
//  PBLMath.swift
//  Logging
//
//  Created by Pete Hoch on 1/25/21.
//

import Foundation

class PBLMath {

    /// Convert number of minutes to a decimal hour in tenths.
    /// The logic in this function is directly take from the 781 Form.
    ///
    /// - Parameter minutes: Number of minutes between 0 and 59
    ///
    /// - Returns: Tenth of an hour.
    ///
    /// - Note: The 781 form rounds up between 0 - 29 minutes and down for > 30 minutes.
    static func decimalTime(_ minutes: UInt) -> Float {
        assert(minutes < 60, "Programming error, minutes need to be between 0 and 59.")

        if 0...2 ~= minutes {
            return 0.0
        } else if 3...8 ~= minutes {
            return 0.1
        } else if 9...14 ~= minutes {
            return 0.2
        } else if 15...20 ~= minutes {
            return 0.3
        } else if 21...26 ~= minutes {
            return 0.4
        } else if 27...33 ~= minutes {
            return 0.5
        } else if 34...39 ~= minutes {
            return 0.6
        } else if 40...45 ~= minutes {
            return 0.7
        } else if 46...51 ~= minutes {
            return 0.8
        } else if 52...57 ~= minutes {
            return 0.9
        }
        return 1.0
    }
}
