//
//  ProfileView.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/27/22.
//
import SwiftUI

struct ProfileView: View {
    let selectedUser: User
    var formattedAddress: String {
        let address = selectedUser.address
        if let range = address.range(of: ", ") {
            return address.replacingCharacters(in: range, with: "\n")
        } else {
            return address
        }
    }
    var loadedUsers: [User]
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                Image(systemName: "circle.fill")
                        .foregroundColor(selectedUser.isActive ? .green : .red)
                Image(systemName: "circle")
                        .foregroundColor(.secondary)
                }
                Text(selectedUser.isActive ? "ONLINE" : "OFFLINE")
                    .foregroundColor(.secondary)
            }
            .font(.system(size: 10))
            Form {
                Section {
                    Text(selectedUser.about)
                } header: {
                    Text("biography")
                }
                Section {
                    HStack{
                        Text("AGE")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(selectedUser.age))
                    }
                    VStack(alignment: .leading) {
                        Text("ADDRESS")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(formattedAddress))
                    }
                    HStack{
                        Text("EMAIL")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(selectedUser.email))
                    }
                    HStack{
                        Text("COMPANY")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(selectedUser.company))
                    }
                } header: {
                    Text("details")
                }
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(selectedUser.tags, id: \.self) { tag in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.secondary.opacity(0.1))
                                    Text("#\(tag)")
                                        .padding(5)
                                }
                            }
                        }
                    }
                } header: {
                    Text("tags")
                }
                Section {
                    ForEach(selectedUser.friends) { friend in
                        if let friendUser = loadedUsers.first(where: {
                            $0.id == friend.id
                        }) {
                            NavigationLink(destination: ProfileView(selectedUser: friendUser, loadedUsers: loadedUsers)) {
                                Text(friendUser.name)
                            }
                        } else {
                            Text(friend.name)
                        }
                    }
                } header: {
                    Text("friends")
                } footer: {
                    Text("Joined \(selectedUser.registered)")
                }
            }
            .navigationTitle(selectedUser.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(selectedUser: User(id: UUID(), isActive: false, name: "E. Xample", age: 20, company: "ExampleCo", email: "example@example.net", address: "5 Example Street, Example City, EX, 55555", about: "This is an example profile.", registered: Date(), tags: ["example", "pesonal", "profile"], friends: [Friend(id: UUID(), name: "S. Ample"), Friend(id: UUID(), name: "P. Review")]), loadedUsers: [User]())
        }
    }
}
