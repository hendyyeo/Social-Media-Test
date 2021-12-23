//
//  Social_Media_TestApp.swift
//  Social Media Test
//
//  Created by Hendy Rusnanto on 22/12/21.
//

import SwiftUI
import Firebase

@main
struct Social_Media_TestApp: App {
    @UIApplicationDelegateAdaptor(Appdelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL (perform: { url in
                    
                    Auth.auth().canHandle(url)
                })
        }
    }
}

//Instalizing Firebase

class Appdelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        
        FirebaseApp.configure()
        return true
    }
    
    //Its Also Should Be Implemented...
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
}
