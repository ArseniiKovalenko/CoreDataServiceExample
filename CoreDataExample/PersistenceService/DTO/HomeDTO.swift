//
//  HomeDTO.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//

import CoreData

struct HomeDTO {
    let url: URL?
    var number: Int
    var ownerName: String
    var roomsCouns: Int
    var street: StreetDTO
    
    init?(_ entity: HomeEntity) {
        guard
            let ownerName = entity.ownerName,
            let street = entity.street,
            let streetDTO = StreetDTO(street)
        else { return nil }
        
        self.number = Int(entity.number)
        self.ownerName = ownerName
        self.roomsCouns = Int(entity.roomsCount)
        self.street = streetDTO
        self.url = entity.objectID.uriRepresentation()
    }
    
    init(number: Int, ownerName: String, roomsCount: Int, street: StreetDTO) {
        self.number = number
        self.ownerName = ownerName
        self.roomsCouns = roomsCount
        self.street = street
        self.url = nil
    }
}
