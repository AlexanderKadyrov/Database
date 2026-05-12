import Foundation
import GRDB

public protocol DatabaseRegisterMigration {
    var name: String { get }
    var creates: [any DatabaseCreateMigration] { get }
}
