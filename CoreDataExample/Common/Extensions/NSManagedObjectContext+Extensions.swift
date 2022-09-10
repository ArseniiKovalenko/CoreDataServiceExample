//
//  NSManagedObjectContext+Extensions.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 09.09.2022.
//

import CoreData

extension NSManagedObjectContext {
    func perform<T>(_ block: () throws -> T) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let value = try block()
                continuation.resume(returning: value)
            } catch let error {
                continuation.resume(throwing: error)
            }
        }
    }
}
