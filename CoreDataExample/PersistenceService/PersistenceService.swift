//
//  PersistenceService.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 01.09.2022.
//

import CoreData

class PersistenceService {
    
    enum ContainerName: String {
        case city = "CityModel"
    }
    
    enum PersistenceError: Error {
        case save(Error)
        case fetch(Error)
        case delete(Error)
        case general(String)
    }
    
    typealias PersistenceErrorClosure = GenericClosure<PersistenceError?>
    typealias PersistenceResultClosure<Success> = ResultClosure<Success, PersistenceError>
    
    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    init(name: ContainerName) {
        let container = NSPersistentContainer(name: name.rawValue)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer = container
        mainContext = persistentContainer.viewContext
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func getObjectID(from url: URL) -> NSManagedObjectID? {
        persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url)
    }
}

extension PersistenceService {
    func fetch<Entity>(on context: NSManagedObjectContext, predicate: NSPredicate? = nil) async throws -> [Entity] where Entity: NSManagedObject {
        try await context.perform {
            let request = Entity.fetchRequest()
            request.predicate = predicate
            
            return try context.fetch(request) as? [Entity] ?? []
        }
    }
    
    func fetch<Entity>(url: URL, on context: NSManagedObjectContext) async throws -> Entity? where Entity: NSManagedObject {
        guard let objectID = getObjectID(from: url) else { throw PersistenceError.general("Not found id from URL: \(url.absoluteString) in context \(context.self)") }
        
        return try await context.perform {
            return context.object(with: objectID) as? Entity
        }
    }
}

extension PersistenceService {
    func delete(url: URL, on context: NSManagedObjectContext) async throws {
        guard let objectID = getObjectID(from: url) else { throw PersistenceError.general("Not found id from URL: \(url.absoluteString) in context \(context.self)") }
        
        try await context.perform {
            let entity = try context.existingObject(with: objectID)
            context.delete(entity)
        }
    }
    
    func deleteAndMergeChanges(on context: NSManagedObjectContext, using batchDeleteRequest: NSBatchDeleteRequest) async throws {
        try await context.perform {
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
            let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]

            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
        }
    }
}

extension PersistenceService {
    func saveContextIfNeeded(_ context: NSManagedObjectContext) async throws {
        try await context.perform {
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
    }
}
