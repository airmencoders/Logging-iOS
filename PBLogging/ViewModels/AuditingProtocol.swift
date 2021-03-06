//
//  AuditingProtocol.swift
//  Logging
//
//  Created by John Bethancourt on 3/5/21.
//

import Foundation

enum DutyPositions{
    case pilot
    case loadmaster
}

protocol Auditing {
    mutating func splitPrimaryEqually()
    var rows: [TimeRow] { get set }
    var ghostRow: DisplayRow { get }
    var totalRow: DisplayRow { get }
    var errors: [String]  { get }
    func save()
    var sortie: Sortie { get }
    var dutyPosition: DutyPositions { get }
    var numLoadmastersRequired: Int16 { get set }
}
