//
//  StorageManager.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 17.04.2023.
//

import CoreData

class StorageManager {

    static let shared = StorageManager()

    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "My_Car_Project")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private let viewContext: NSManagedObjectContext

    private init() {
        viewContext = persistentContainer.viewContext
    }

    // MARK: - CRUD
    func fetchData(completion: (Result<[Expenses], Error>) -> Void) {
        let fetchRequest = Expenses.fetchRequest()

        do {
            let expenses = try self.viewContext.fetch(fetchRequest)
            completion(.success(expenses))
        } catch let error {
            completion(.failure(error))
        }
    }

  func create(_ expenseName: String, completion: (Expenses) -> Void) {
      let expense = Expenses(context: viewContext)
      expense.title = expenseName
      completion(expense)
      saveContext()
  }

    func update(_ expenses: Expenses, newName: String) {
      expenses.title = newName
        saveContext()
    }

    func delete(_ expenses: Expenses) {
        viewContext.delete(expenses)
        saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

