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
        
        /// This is temporary but will be necessary for a while.
        /// The MERS data will be on PBS, and configured by the unit. We will then
        /// download and update the data model from that, instead of this:
        SampleData.createSampleDownloadedMERSData(context: dataController.container.viewContext)
        
        let contentView = ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        
        // Check for first run, if so load example data
        if(UserDefaults().bool(forKey: "PBL-HAS-RUN-BEFORE") != true){
            firstLoad()
        }
        
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
            SampleData.loadMockData1(viewContext: dataController.container.viewContext, numEvents: 6)
           
        }else if ProcessInfo.processInfo.arguments.contains("clear-core-data") {
            dataController.deleteAllEvents()
            dataController.save()
        }
    }
    
    //Loads dummy data on first install
    func firstLoad(){
        SampleData.loadFEMAMission(viewContext: dataController.container.viewContext)
        SampleData.loadMockData1(viewContext: dataController.container.viewContext, numEvents: 1)
        
        UserDefaults().set(true, forKey: "PBL-HAS-RUN-BEFORE")
        UserDefaults().synchronize()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        dataController.save()
    }
}

