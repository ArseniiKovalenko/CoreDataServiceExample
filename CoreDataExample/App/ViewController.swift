//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Arsenii Kovalenko on 01.09.2022.
//

import UIKit

class ViewController: UIViewController {

    let persistenceService = PersistenceService(name: .city)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let city = await persistenceService.fetch(url: URL(string: "x-coredata://A28938D7-705B-4F02-8DDC-96D17ACBD3B0/City/p2")!)
            print(city!)
        }
    }
}

/*
 x-coredata://A28938D7-705B-4F02-8DDC-96D17ACBD3B0/City/p1
 x-coredata://A28938D7-705B-4F02-8DDC-96D17ACBD3B0/City/p2
 x-coredata://A28938D7-705B-4F02-8DDC-96D17ACBD3B0/City/p3
 x-coredata://A28938D7-705B-4F02-8DDC-96D17ACBD3B0/City/p4
 */
