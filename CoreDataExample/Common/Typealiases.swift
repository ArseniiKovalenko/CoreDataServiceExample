//
//  Typealiases.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 02.09.2022.
//

import Foundation

typealias EmptyClosure = () -> Void

typealias GenericClosure<T> = (T) -> Void

typealias ResultClosure<Success, Failure> = GenericClosure<Result<Success, Failure>> where Failure: Error
