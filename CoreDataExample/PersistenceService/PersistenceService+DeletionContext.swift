//
//  PersistenceService+DeletionContext.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 10.09.2022.
//

import Foundation

protocol PersistenceServiceDeletionContext: PersistenceService {
    func delete(url: URL) async
}

extension PersistenceServiceDeletionContext {
    func delete(url: URL) async {
        do {
            try await delete(url: url, on: backgroundContext)
            try await saveContextIfNeeded(backgroundContext)
        } catch let error {
            assertionFailure("Deletion error of entity with URL: \(url.absoluteString). Error: \(error)")
        }
    }
}
