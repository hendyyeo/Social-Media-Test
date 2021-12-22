//
//  Social_Media_TestApp.swift
//  Social Media Test
//
//  Created by Hendy Rusnanto on 22/12/21.
//

import SwiftUI

@main
struct Social_Media_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
