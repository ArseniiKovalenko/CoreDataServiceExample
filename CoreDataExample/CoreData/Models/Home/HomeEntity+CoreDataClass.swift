//
//  HomeEntity+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//
//

import CoreData

public class HomeEntity: NSManagedObject {

    @discardableResult
    convenience init(home: HomeDTO, insertInto context: NSManagedObjectContext) {
        self.init(entity: StreetEntity.entity(), insertInto: context)
        self.roomsCount = Int64(home.roomsCouns)
        self.ownerName = home.ownerName
        self.number = Int64(home.number)
        self.street = StreetEntity(street: home.street, insertInto: context)
    }
}
