//
//  CachedUser+CoreDataProperties.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/29/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    public var unwrappedAbout: String { about ?? "" }
    public var unwrappedAddress: String { address ?? "" }
    public var unwrappedCompany: String { company ?? "" }
    public var unwrappedEmail: String { email ?? "" }
    public var unwrappedId: UUID { id ?? UUID() }
    public var unwrappedName: String { name ?? "" }
    public var unwrappedRegistered: Date { registered ?? Date.now }
    public var unwrappedTags: [String] {
        (self.tags ?? "").components(separatedBy: ",")
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
