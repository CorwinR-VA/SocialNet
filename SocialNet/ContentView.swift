//
//  ContentView.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedContext
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink(destination: ProfileView(selectedUser: user, cachedUsers: cachedUsers)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(user.unwrappedName)
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
                            Text(user.unwrappedCompany)
                            Text("COMPANY")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .task {
                await loadJSONData()
            }
            .navigationTitle("SocialNet")
//            .toolbar {
//                Menu {
//                    Button { loadedUsers.sort(by: { $0.name < $1.name })
//                    } label: { Label("Alphabetical", systemImage: "abc")}
//                    Button { loadedUsers.sort(by: { $0.isActive && !$1.isActive })
//                    } label: { Label("Status", systemImage: "power") }
//                    Button { loadedUsers.sort(by: { $0.company < $1.company })
//                    } label: { Label("Company", systemImage: "building.2") }
//                    Button { loadedUsers.sort(by: { $0.registered < $1.registered })
//                    } label: { Label("Joined", systemImage: "calendar") }
//                } label: {
//                    Label("sort", systemImage: "arrow.up.arrow.down")
//                }
//            }
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
            for user in decoded {
                saveCachedData(user: user)
            }
        } catch {
            print("Invalid Data")
        }
    }
    func saveCachedData(user: User) {
        let funcUser = CachedUser(context: managedContext)
        let funcFriend = CachedFriend(context: managedContext)
        funcUser.id = user.id
        funcUser.isActive = user.isActive
        funcUser.name = user.name
        funcUser.age = user.age
        funcUser.company = user.company
        funcUser.email = user.email
        funcUser.address = user.address
        funcUser.about = user.about
        funcUser.registered = user.registered
        funcUser.tags = user.tags.joined(separator: ",")
        for friend in user.friends {
            funcFriend.id = friend.id
            funcFriend.name = friend.name
        }
        try? managedContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
