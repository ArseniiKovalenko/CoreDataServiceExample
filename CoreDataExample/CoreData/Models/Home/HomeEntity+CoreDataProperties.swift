//
//  HomeEntity+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//
//

import CoreData

extension HomeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HomeEntity> {
        return NSFetchRequest<HomeEntity>(entityName: "Home")
    }

    @NSManaged public var roomsCount: Int64
    @NSManaged public var ownerName: String?
    @NSManaged public var number: Int64
    @NSManaged public var street: StreetEntity?

}

extension HomeEntity: Identifiable {

}
