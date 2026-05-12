import Foundation
import DI

fileprivate extension DIStorage {
    struct DatabaseServiceKey: DIKey {
        nonisolated(unsafe) static var currentValue: DatabaseService = DatabaseServiceImpl()
    }
}

public extension DIStorage {
    var databaseService: DatabaseService {
        get { Self.self[DatabaseServiceKey.self] }
        set { Self.self[DatabaseServiceKey.self] = newValue }
    }
}
