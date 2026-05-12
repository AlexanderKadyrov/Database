import Foundation
import GRDB

extension DatabaseWriter {
    
    func register(migrations: [any DatabaseRegisterMigration]) throws {
        var databaseMigrator = DatabaseMigrator()
        for migration in migrations {
            let creates = migration.creates
            databaseMigrator.registerMigration(migration.name) { database in
                for element in creates {
                    try element.prepare(on: database)
                }
            }
        }
        try databaseMigrator.migrate(self)
    }
}
