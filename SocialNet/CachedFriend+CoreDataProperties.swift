//
//  CachedFriend+CoreDataProperties.swift
//  SocialNet
//
//  Created by Corwin Rainier on 7/29/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var origin: CachedUser?

    public var unwrappedId: UUID { id ?? UUID() }
    public var unwrappedName: String { name ?? "" }
}

extension CachedFriend : Identifiable {

}
