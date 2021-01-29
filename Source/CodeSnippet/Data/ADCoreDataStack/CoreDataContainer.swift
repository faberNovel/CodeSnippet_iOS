//
//  CoreDataContainer.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 29/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import CoreData
import Foundation

final class CoreDataContainer {

    private let persistentContainer: NSPersistentContainer
    private lazy var backgroundContext: NSManagedObjectContext = self.makeBackgroundContext()

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Life Cycle

    private init() {
        let url = Bundle(for: CoreDataContainer.self)
            .url(forResource: "CodeSnippet", withExtension: "momd")
        guard let managedObjectModel = url.flatMap(NSManagedObjectModel.init(contentsOf:)) else {
            fatalError("Can't find CodeSnippet.momd in Data.framework")
        }
        persistentContainer = NSPersistentContainer(
            name: "CodeSnippet",
            managedObjectModel: managedObjectModel
        )
        persistentContainer.loadPersistentStores { _, error in
            guard let error = error else { return }
            fatalError(error.localizedDescription)
        }
    }

    // MARK: - CoreDataContainer

    func performBackgroundTask(_ task: @escaping (NSManagedObjectContext) -> Void) {
        let context = backgroundContext
        context.perform {
            task(context)
        }
    }

    func childManagedObjectContext() -> NSManagedObjectContext {
        return backgroundContext
    }

    // MARK: - Private

    private func makeBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return context
    }
}
