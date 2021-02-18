//
//  Sortie+Calculations.swift
//  TimeSplit3
//
//  Created by John Bethancourt on 2/7/21.
//

import Foundation

extension Sortie {

    // the sorties flight time as decimal hour string with one decimal place, returns "" if calculation returns nil
    var flightTimeString: String {
        guard let time = self.calculatedTotalFlightTimeFor781 else { return "" }
        let string = String(format: "%.1f", time)
        return string
    }

    // the sorties flight time as a decimal hour. Nil if missing date or begin date is beyond end date
    var calculatedTotalFlightTimeFor781: Double? {

        guard let start = takeoffTime   else { return nil }
        guard let end = landTime        else { return nil }
        guard  end > start              else { return nil }

        return timeBetweenDatesFor781(start: start, end: end)
    }

    /// Calculates the time between date/times in a way only used by the AFTO Form 781
    /// - Parameters:
    ///   - start: the start date/time
    ///   - end: the end date/time
    /// - Returns: the decimal hours from start to end.
    private func timeBetweenDatesFor781(start: Date, end: Date) -> Double {
        let interval = end.timeIntervalSince(start)
        let seconds = Int(interval)
        let hours = seconds / 3600
        let minutes = seconds % 3600 / 60

        let tenths = tenthsOfAnHour(fromMinutes: minutes)

        return Double(Double(hours) + tenths)
    }

    /// Converts a number of minutes to tenths of an hour as defined by the AFTO Form 781.
    ///
    /// It returns equivalent of:
    ///
    ///  `return n < 30 ? round(Double(n)/6.0) / 10.0 : round(Double(n)/6.1) / 10.0`
    ///
    /// The table version below matches the one on the form. It reads nicer
    /// and will be easier to update if ever needed.
    ///
    /// - Parameter minutes: The number of minutes between 0 and 59 to convert.
    ///
    /// - Returns: Tenths of an hour.
    private func tenthsOfAnHour<B: BinaryInteger>(fromMinutes minutes: B) -> Double {
        switch minutes {
        case 0...2:     return 0.0
        case 3...8:     return 0.1
        case 9...14:    return 0.2
        case 15...20:   return 0.3
        case 21...26:   return 0.4
        case 27...33:   return 0.5
        case 34...39:   return 0.6
        case 40...45:   return 0.7
        case 46...51:   return 0.8
        case 52...57:   return 0.9
        default:        return 1.0
        }
    }
}
