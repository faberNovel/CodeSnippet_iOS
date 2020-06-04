//
//  CoreDataObject.swift
//  XCTemplate
//
//  Created by Gaétan Zanella on 02/06/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import CoreData
import Foundation

protocol CoreDataObject: NSManagedObject {}
extension NSManagedObject: CoreDataObject {}

extension CoreDataObject {

    static var entityName: String {
        return NSStringFromClass(Self.self)
    }

    // MARK: - Life Cycle

    init?(context: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: Self.entityName, in: context) else {
            return nil
        }
        self.init(entity: entity, insertInto: context)
    }

    // MARK: - Public

    static func fetchAll(in context: NSManagedObjectContext) throws -> [Self] {
        let request = self.fetchRequest()
        let values = try context.fetch(request)
        return (values as? [Self]) ?? []
    }

    static func first(in context: NSManagedObjectContext, where predicate: NSPredicate) throws -> Self? {
        return try find(in: context, where: predicate).first
    }

    static func find(in context: NSManagedObjectContext, where predicate: NSPredicate) throws -> [Self] {
        let request = Self.fetchRequest()
        request.predicate = predicate
        let values = try context.fetch(request)
        return (values as? [Self]) ?? []
    }
}

extension CoreDataObject where Self: Identifiable, Self.ID == String {

    static func first(in context: NSManagedObjectContext, with id: ID) throws -> Self? {
        let predicate = NSPredicate(format: "id == %@", id)
        return try first(in: context, where: predicate)
    }
}
