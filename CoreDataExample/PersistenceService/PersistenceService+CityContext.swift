//
//  PersistenceService+CityContext.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//

import Foundation

protocol PersistenceServiceCityContext: PersistenceServiceDeletionContext {
    func create(city: CityDTO) async
    func fetch() async -> [CityDTO]
    func fetch(url: URL) async -> CityDTO?
}

extension PersistenceService: PersistenceServiceCityContext {
    func create(city: CityDTO) async {
        do {
            try await backgroundContext.perform { [weak self] in
                guard let self = self else { return }
                
                CityEntity(city: city, insertInto: self.backgroundContext)
            }
            
            try await saveContextIfNeeded(backgroundContext)
        } catch let error {
            assertionFailure("Creation error of \(city.self). Error: \(error)")
        }
    }
    
    func fetch() async -> [CityDTO] {
        do {
            let entities: [CityEntity] = try await fetch(on: mainContext)
            return entities.compactMap { CityDTO($0) }
        } catch let error {
            assertionFailure("Fetch error of \([CityEntity].self) entity. Error: \(error)")
            return []
        }
    }
    
    func fetch(url: URL) async -> CityDTO? {
        do {
            guard let entity: CityEntity = try await fetch(url: url, on: mainContext) else { return nil }
            
            return CityDTO(entity)
        } catch let error {
            assertionFailure("Fetch error of \(CityEntity.self) entity. Error: \(error)")
            return nil
        }
    }
}
