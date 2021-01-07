//
//  AlertProvider.swift
//  Logging
//
//  Created by John Bethancourt on 1/6/21.
//

import Combine
import SwiftUI

/// Publishes alert state signal and provides alerts as called
///
/// Observed by any view modified by the AlertViewModifier.
/// Should only be placed on a single container view
///
class AlertProvider: ObservableObject{
    
    @Published var alertIsVisible = false
  
    public var alert: Alert!
    
    static let shared = AlertProvider()
    
    enum AlertType{
        
        case persistence
        case ugly
        
        func getAlert() -> Alert{
            switch self{
            case .persistence:
            return Alert(title: Text("Persistence Error"), message: Text("There was a database problem"), dismissButton: .default(Text("Got it!")))
            case .ugly:
            return Alert(title: Text("You're ugly"), message: Text("U.G.L.Y. you ain’t got no alibi"), dismissButton: .default(Text("That makes me sad.")))

            }
        }
    }
    
    /// Creates an alert and signals for its showing
    ///
    /// - Parameters:
    ///   - alert: Custom alert view struct to show
    func showAlert(_ alert: Alert){
        self.alert = alert
        self.alertIsVisible = true
    }
 
    /// Creates an alert and signals for its showing
    ///
    /// - Parameters:
    ///   - type: A custom AlertType constructed in the AlertProvider class
    func showAlert(_ type:AlertType){
        self.alert = type.getAlert()
        self.alertIsVisible = true
    }
    
    /// Creates an alert and signals for its showing
    ///
    /// - Parameters:
    ///   - title: text for the the title of the alert. Defaults to "Error"
    ///   - message: the message to show in the alert
    ///   - dismissButtonText: the text to show on the dismissal button. Defaults to "OK"
    func showAlertWithTitle(title: String = "Error", message: String, dismissButtonText: String = "OK"){
        self.alert = Alert(title: Text(title), message: Text(message), dismissButton: .default(Text(dismissButtonText)))
        self.alertIsVisible = true
    }
    
}

/// Modifier that allows any view to become a displayer of alerts sourced from the AlertProvider publisher class
struct AlertViewModifier: ViewModifier {
    
    @ObservedObject var alertProvider = AlertProvider.shared
    
    func body(content: Content) -> some View {
          content
            .alert(isPresented: $alertProvider.alertIsVisible) {
                alertProvider.alert
            }
      }
    
}

extension View {
    /// A view modifier extension for convenience usage of the AlertViewModifier
    ///
    /// Usage as follows:
    ///
    ///     ContentView()
    ///     .alertProvider()
    ///
    func alertProvider() -> some View {
        self.modifier(AlertViewModifier())
    }
}
