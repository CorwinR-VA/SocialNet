//
//  ContentView.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/26/22.
//
import SwiftUI

struct ContentView: View {
    @State var loadedUsers = [User]()
    
    var body: some View {
        NavigationView {
            List(loadedUsers) { user in
                NavigationLink(destination: ProfileView(selectedUser: user, loadedUsers: loadedUsers)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(user.name)
                                .lineLimit(1)
                            HStack(spacing: 1) {
                                ZStack {
                                Image(systemName: "circle.fill")
                                        .foregroundColor(user.isActive ? .green : .red)
                                Image(systemName: "circle")
                                        .foregroundColor(.secondary)
                                }
                                Text(user.isActive ? "ONLINE" : "OFFLINE")
                                    .foregroundColor(.secondary)
                            }
                            .font(.system(size: 10))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        VStack {
                            Text(String(user.age))
                            Text("AGE")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                        VStack {
                            Text(user.company)
                            Text("COMPANY")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .task {
                if loadedUsers.isEmpty {
                    await loadJSONData()
                }
            }
            .navigationTitle("SocialNet")
            .toolbar {
                Menu {
                    Button {
                        loadedUsers.sort(by: {
                            $0.name < $1.name
                        })
                    } label: {
                        Label("Alphabetical", systemImage: "abc")
                    }
                    Button {
                        loadedUsers.sort(by: {
                            $0.isActive && !$1.isActive
                        })
                    } label: {
                        Label("Status", systemImage: "power")
                    }
                    Button {
                        loadedUsers.sort(by: {
                            $0.company < $1.company
                        })
                    } label: {
                        Label("Company", systemImage: "building.2")
                    }
                    Button {
                        loadedUsers.sort(by: {
                            $0.registered < $1.registered
                        })
                    } label: {
                        Label("Joined", systemImage: "calendar")
                    }
                } label: {
                    Label("sort", systemImage: "arrow.up.arrow.down")
                }
            }
        }
    }

    func loadJSONData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let strategy = JSONDecoder()
        strategy.dateDecodingStrategy = .iso8601
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try strategy.decode([User].self, from: data)
            loadedUsers = decoded
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
