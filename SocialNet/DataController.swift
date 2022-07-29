//
//  DataController.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/29/22.
//

import CoreData
import Foundation

class Controller: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Data failed to load from: \(error.localizedDescription)")
            }
        }
    }
}
