//
//  StreetDTO.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 10.09.2022.
//

import CoreData

struct StreetDTO {
    let url: URL?
    var name: String
    var city: CityDTO
    var homes: [HomeDTO]
    
    init?(_ entity: StreetEntity) {
        guard
            let name = entity.name,
            let city = entity.city,
            let cityDTO = CityDTO(city)
        else { return nil }
        
        self.name = name
        self.homes = Array(_immutableCocoaArray: entity.homes ?? NSOrderedSet())
        self.city = cityDTO
        self.url = entity.objectID.uriRepresentation()
    }
    
    init(name: String, city: CityDTO, homes: [HomeDTO] = []) {
        self.name = name
        self.city = city
        self.homes = homes
        self.url = nil
    }
}
