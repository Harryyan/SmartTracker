//
//  TransactionRepository.swift
//  TransactionRepository
//
//  Created by Harry Yan on 18/08/21.
//

import Combine
import CoreData

final class TransactionRepository: TransactionProvider {
    private var managedObjectContext: NSManagedObjectContext
    
    var transactionPublisher: Published<[Transaction]>.Publisher { $transactionLogs }
    @Published var transactionLogs: [Transaction] = []
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        
        publish()
    }
    
    // MARK: - Internal
    
    func loadAllTransactions() {
        let sort = NSSortDescriptor(key: "occuredOn", ascending: false)
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        fetchRequest.sortDescriptors = [sort]
        
        do {
            transactionLogs = try self.managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func loadCurrentMonthTransactions(for category: String) -> [Transaction] {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let categoryFilter = NSPredicate(format: "category == %@", category)
        let monthFilter = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@", Date().startOfMonth as NSDate, Date().endOfMonth as NSDate)
        let filters = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryFilter, monthFilter])
        fetchRequest.predicate = filters

        do {
            let values = try self.managedObjectContext.fetch(fetchRequest)
            return values
        } catch let error as NSError  {
            print("\(error), \(error.userInfo)")
            return []
        }
    }
    
    func upsert(transaction: Transaction) {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        
        publish()
    }
    
    func delete(transaction: Transaction) {
        managedObjectContext.delete(transaction)
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        
        publish()
    }
    
    // MARK: - Private
    
    private func publish() {
        loadAllTransactions()
    }
}
