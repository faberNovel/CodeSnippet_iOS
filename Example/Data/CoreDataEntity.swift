//
//  CoreDataEntity.swift
//  XCTemplate
//
//  Created by Gaétan Zanella on 15/05/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import CoreData
import Foundation

protocol CoreDataEntity: NSManagedObject {
    static var entityName: String { get }
}

extension CoreDataEntity {

    static var entityName: String {
        return NSStringFromClass(Self.self)
    }
}

extension CoreDataEntity {

    init?(context: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: Self.entityName, in: context) else {
            return nil
        }
        self.init(entity: entity, insertInto: context)
    }
}
