//
//  CityEntity+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//
//

import CoreData

public class CityEntity: NSManagedObject {
    
    @discardableResult
    convenience init(city: CityDTO, insertInto context: NSManagedObjectContext) {
        self.init(entity: CityEntity.entity(), insertInto: context)
        self.name = city.name
        self.region = city.region
        addToStreets(city.streets)
    }
    
    func addToStreets(_ value: StreetDTO) {
        guard let context = managedObjectContext else { return }
        addToStreets(StreetEntity(street: value, insertInto: context))
    }
    
    func addToStreets(_ values: [StreetDTO]) {
        guard let context = managedObjectContext, !values.isEmpty else { return }
        let entities = values.map { StreetEntity(street: $0, insertInto: context) }
        addToStreets(NSSet(array: entities))
    }
}
