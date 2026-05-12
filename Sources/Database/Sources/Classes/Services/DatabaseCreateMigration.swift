import Foundation
import GRDB

public protocol DatabaseCreateMigration: Sendable {
    func prepare(on database: Database) throws
}
