//
//  CityEntity+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//
//

import CoreData

extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var region: String?
    @NSManaged public var streets: NSSet?
}

// MARK: Generated accessors for streets
extension CityEntity {

    @objc(addStreetsObject:)
    @NSManaged public func addToStreets(_ value: StreetEntity)

    @objc(removeStreetsObject:)
    @NSManaged public func removeFromStreets(_ value: StreetEntity)

    @objc(addStreets:)
    @NSManaged public func addToStreets(_ values: NSSet)

    @objc(removeStreets:)
    @NSManaged public func removeFromStreets(_ values: NSSet)

}

extension CityEntity: Identifiable {

}
