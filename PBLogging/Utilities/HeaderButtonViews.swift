//
//  HeaderButtonViews.swift
//  Logging
//
//  Created by Bethany Morris on 2/2/21.
//

import SwiftUI

class HeaderButtonViews: ObservableObject {
    
    @Published var viewText: String = "Overview"
    @Published var currentView: PBLView = .overview
    
}

enum PBLView {
    case overview
    case form781
    case flightSeq
    case aircrewList
    case aircrewData
}

