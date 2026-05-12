import Foundation

public protocol DatabaseService {
    
    func register(migrations: [any DatabaseRegisterMigration]) throws
    
    func save(entities: [any EntityDTO]) async throws
    
    func fetchAll<E: EntityDTO>(type: E.Type, sql: String?) async throws -> [E]
    func fetchOne<E: EntityDTO>(type: E.Type, sql: String?) async throws -> E?
}
