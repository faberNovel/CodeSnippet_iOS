//___FILEHEADER___

import CoreData
import Foundation

class CoreDataContainer {

    private let container: NSPersistentContainer

    // MARK: - Life Cycle

    init(container: NSPersistentContainer) {
        self.container = container
        container.loadPersistentStores { _, error in
            guard let error = error else { return }
            fatalError(error.localizedDescription)
        }
    }

    // MARK: - Public

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        container.newBackgroundContext()
    }

    func performInBackgroundContext(block: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(block)
    }
}
