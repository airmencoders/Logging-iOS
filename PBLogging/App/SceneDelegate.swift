//
//  SceneDelegate.swift
//  Logging
//
//  Created by Pete Hoch on 12/31/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    @ObservedObject var dataController: DataController

    override init() {
        let controller = DataController()
        _dataController = ObservedObject(wrappedValue: controller)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        #if DEBUG
        checkForUITestArguments()
        #endif
        
        let contentView = ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func checkForUITestArguments() {
        
        if ProcessInfo.processInfo.arguments.contains("ui-tests") {
            UIView.setAnimationsEnabled(false)
        }
        if ProcessInfo.processInfo.arguments.contains("clear-core-data-load-sample-data") {
            dataController.deleteAllEvents()
            SampleData.loadMockData1(viewContext: dataController.container.viewContext)
           
        }else if ProcessInfo.processInfo.arguments.contains("clear-core-data") {
            dataController.deleteAllEvents()
            dataController.save()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        dataController.save()
    }
}

