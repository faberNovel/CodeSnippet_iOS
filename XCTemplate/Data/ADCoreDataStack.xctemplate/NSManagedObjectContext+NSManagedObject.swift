//___FILEHEADER___

import CoreData
import Foundation

enum CoreDataError: Error {
    case resourceNotFound
}

@objc protocol CoreDataIdentifiable {
    @objc var customId: String { get set }
}

extension NSManagedObject {

    class var entityName: String {
        return String(describing: self)
    }
}

extension NSManagedObjectContext {

    func insertObject<A: NSManagedObject>(_ object: A.Type) -> A {
        guard let insertedObject = NSEntityDescription
            .insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Entity \(A.entityName) does not correspond to \(A.self)")
        }
        return insertedObject
    }

    func count<A: NSManagedObject>(_ object: A.Type, predicate: NSPredicate? = nil) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: object.entityName)
        fetchRequest.includesSubentities = false
        fetchRequest.includesPropertyValues = false
        fetchRequest.predicate = predicate
        return (try? count(for: fetchRequest)) ?? -1
    }

    func fetchAll<A: NSManagedObject>(_ type: A.Type,
                                      sortDescriptors: [NSSortDescriptor] = [],
                                      predicate: NSPredicate? = nil) -> [A] {
        let fetchRequest = NSFetchRequest<A>(entityName: A.entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        return (try? fetch(fetchRequest)) ?? []
    }

    // Avoid fetch request if possible
    func findOrFetch<A: NSManagedObject>(_ type: A.Type, predicate: NSPredicate) -> A? {
        guard let object: A = materialized(type, predicate: predicate) else {
            return fetchAll(type, predicate: predicate).first
        }
        return object
    }

    // We look for the object in context, and avoid fetch request
    func materialized<A: NSManagedObject>(_ type: A.Type, predicate: NSPredicate) -> A? {
        for object in registeredObjects where !object.isFault {
            guard let result = object as? A, predicate.evaluate(with: result) else {
                continue
            }
            return result
        }
        return nil
    }

}

extension NSManagedObjectContext {

    func fetch<A: NSManagedObject>(_ type: A.Type,
                                   withID id: String) -> Result<A, CoreDataError> where A: CoreDataIdentifiable {
        if let resource = fetch(type, withID: id) as A? {
            return .success(resource)
        } else {
            return .failure(.resourceNotFound)
        }
    }

    func fetch<A: NSManagedObject>(_ type: A.Type,
                                   withID id: String,
                                   // swiftlint:disable:next line_length
                                   completion: @escaping (Result<A, CoreDataError>) -> Void) where A: CoreDataIdentifiable {
        perform {
            if let resource = self.fetch(type, withID: id) as A? {
                DispatchQueue.main.async {
                    completion(.success(resource))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.resourceNotFound))
                }
            }
        }
    }

    func fetch<A: NSManagedObject>(_ type: A.Type, withID id: String) -> A? where A: CoreDataIdentifiable {
        return findOrFetch(type, predicate: NSPredicate(format: "%K == %@", #keyPath(CoreDataIdentifiable.customId), id))
    }

    func fetchOrCreate<A: NSManagedObject>(_ type: A.Type, id: String) -> A where A: CoreDataIdentifiable {
        guard let result: A = fetch(type, withID: id) else {
            let insertedObject = insertObject(type)
            insertedObject.customId = id
            return insertedObject
        }
        return result
    }

    func fetchAll<A: NSManagedObject>(_ type: A.Type,
                                      matchingIDs ids: [String]) -> [A] where A: CoreDataIdentifiable {
        guard !ids.isEmpty else {
            return []
        }
        let fetchRequest = NSFetchRequest<A>(entityName: A.entityName)
        fetchRequest.predicate = NSPredicate(format: "%K IN %@", #keyPath(CoreDataIdentifiable.customId), ids)
        return (try? fetch(fetchRequest)) ?? []
    }
}
