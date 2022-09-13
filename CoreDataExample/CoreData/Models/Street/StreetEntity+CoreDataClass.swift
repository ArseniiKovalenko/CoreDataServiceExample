//
//  StreetEntity+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//
//

import CoreData

public class StreetEntity: NSManagedObject {
    
    @discardableResult
    convenience init(street: StreetDTO, insertInto context: NSManagedObjectContext) {
        self.init(entity: StreetEntity.entity(), insertInto: context)
        self.name = street.name
        self.city = CityEntity(city: street.city, insertInto: context)
        addToHomes(street.homes)
    }
    
    func addToHomes(_ value: HomeDTO) {
        guard let context = managedObjectContext else { return }
        addToHomes(HomeEntity(home: value, insertInto: context))
    }
    
    func addToHomes(_ values: [HomeDTO]) {
        guard let context = managedObjectContext, !values.isEmpty else { return }
        let entities = values.map { HomeEntity(home: $0, insertInto: context) }
        addToHomes(NSOrderedSet(array: entities))
    }
}
