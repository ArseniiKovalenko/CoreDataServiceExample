//
//  StreetEntity+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//
//

import CoreData

extension StreetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StreetEntity> {
        return NSFetchRequest<StreetEntity>(entityName: "Street")
    }

    @NSManaged public var name: String?
    @NSManaged public var homes: NSOrderedSet?
    @NSManaged public var city: CityEntity?

}

// MARK: Generated accessors for homes
extension StreetEntity {

    @objc(insertObject:inHomesAtIndex:)
    @NSManaged public func insertIntoHomes(_ value: HomeEntity, at idx: Int)

    @objc(removeObjectFromHomesAtIndex:)
    @NSManaged public func removeFromHomes(at idx: Int)

    @objc(insertHomes:atIndexes:)
    @NSManaged public func insertIntoHomes(_ values: [HomeEntity], at indexes: NSIndexSet)

    @objc(removeHomesAtIndexes:)
    @NSManaged public func removeFromHomes(at indexes: NSIndexSet)

    @objc(replaceObjectInHomesAtIndex:withObject:)
    @NSManaged public func replaceHomes(at idx: Int, with value: HomeEntity)

    @objc(replaceHomesAtIndexes:withHomes:)
    @NSManaged public func replaceHomes(at indexes: NSIndexSet, with values: [HomeEntity])

    @objc(addHomesObject:)
    @NSManaged public func addToHomes(_ value: HomeEntity)

    @objc(removeHomesObject:)
    @NSManaged public func removeFromHomes(_ value: HomeEntity)

    @objc(addHomes:)
    @NSManaged public func addToHomes(_ values: NSOrderedSet)

    @objc(removeHomes:)
    @NSManaged public func removeFromHomes(_ values: NSOrderedSet)

}

extension StreetEntity: Identifiable {

}
