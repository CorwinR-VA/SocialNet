//
//  ContentView.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/26/22.
//

import SwiftUI

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tages: [String]
    var friends: [Friend]
}
struct Friend: Codable, Identifiable {
    var id: String
    var name: String
}


struct ContentView: View {
    @State private var items = [User]()
    
    var body: some View {
        NavigationView {
            List(items) { item in
                Text(item.name)
            }
            .task {
                await uploadJSONData()
            }
            .navigationTitle("SocialNet")
        }
    }

    func uploadJSONData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([User].self, from: data)
            items = decoded
        } catch {
            print("Invalid Data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
