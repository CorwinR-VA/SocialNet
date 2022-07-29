//
//  SocialNetApp.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/26/22.
//

import SwiftUI

@main
struct SocialNetApp: App {
    @StateObject private var dataController = Controller()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
