//
//  PersistenceService+CityContext.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//

import Foundation

protocol PersistenceServiceCityContext: PersistenceServiceDeletionContext {
    func create(city: CityDTO) async
    func fetch() async -> [CityEntity]
    func fetch(url: URL) async -> CityEntity?
}

extension PersistenceService: PersistenceServiceCityContext {
    func create(city: CityDTO) async {
        do {
            try await backgroundContext.perform {
                let entity = CityEntity(context: backgroundContext)
                entity.name = city.name
                entity.region = city.region
            }
            
            try await saveContextIfNeeded(backgroundContext)
        } catch let error {
            assertionFailure("Creation error of \(city.self). Error: \(error)")
        }
    }
    
    func fetch() async -> [CityEntity] {
        do {
            return try await fetch(on: mainContext)
        } catch let error {
            assertionFailure("Fetch error of \([CityEntity].self) entity. Error: \(error)")
            return []
        }
    }
    
    func fetch(url: URL) async -> CityEntity? {
        do {
            return try await fetch(url: url, on: mainContext)
        } catch let error {
            assertionFailure("Fetch error of \(CityEntity.self) entity. Error: \(error)")
            return nil
        }
    }
}
