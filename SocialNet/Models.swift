//
//  Models.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/27/22.
//
import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
