//
//  CityDTO.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 10.09.2022.
//

import CoreData

struct CityDTO {
    let url: URL?
    var name: String
    var region: String
    var streets: [StreetDTO]
    
    var totalHomesCount: Int {
        streets.reduce(0) { $0 + $1.homes.count }
    }
    
    init?(_ entity: CityEntity) {
        guard let name = entity.name, let region = entity.region else { return nil }
        
        self.url = entity.objectID.uriRepresentation()
        self.name = name
        self.region = region
        self.streets = Array(_immutableCocoaArray: entity.streets ?? NSSet())
    }
    
    init(name: String, region: String, streets: [StreetDTO] = []) {
        self.name = name
        self.region = region
        self.streets = streets
        self.url = nil
    }
}
