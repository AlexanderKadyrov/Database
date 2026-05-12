import Foundation
import GRDB

struct DatabaseServiceImpl: DatabaseService {
    
    private enum Errors: Error {
        case badDatabaseQueue
    }
    
    private let databaseQueue: DatabaseQueue? = {
        do {
            return try DatabaseQueue(name: "db.sqlite")
        } catch {
            return nil
        }
    }()
    
    func register(migrations: [any DatabaseRegisterMigration]) throws {
        guard let databaseQueue else {
            throw Errors.badDatabaseQueue
        }
        try databaseQueue.register(migrations: migrations)
    }
    
    func save(entities: [any EntityDTO]) async throws {
        guard let databaseQueue else {
            throw Errors.badDatabaseQueue
        }
        try await databaseQueue.write { database in
            for element in entities {
                try element.save(database)
            }
        }
    }
    
    func fetchAll<E: EntityDTO>(type: E.Type, sql: String?) async throws -> [E] {
        guard let databaseQueue else {
            throw Errors.badDatabaseQueue
        }
        return try await databaseQueue.read { database in
            guard let sql else {
                return try E.fetchAll(database)
            }
            return try E.fetchAll(database, sql: sql)
        }
    }
    
    func fetchOne<E: EntityDTO>(type: E.Type, sql: String?) async throws -> E? {
        guard let databaseQueue else {
            throw Errors.badDatabaseQueue
        }
        return try await databaseQueue.read { database in
            guard let sql else {
                return try E.fetchOne(database)
            }
            return try E.fetchOne(database, sql: sql)
        }
    }
}
