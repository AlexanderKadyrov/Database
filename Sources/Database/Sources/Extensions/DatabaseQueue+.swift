import Foundation
import GRDB

extension DatabaseQueue {
    
    convenience init(name: String) throws {
        try self.init(path: Self.file(name: name))
    }
}

fileprivate extension DatabaseQueue {
    
    static func file(name: String) throws -> String {
        let fileManager = FileManager.default
        let applicationSupportDirectoryURL = try fileManager.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let databaseDirectoryURL = applicationSupportDirectoryURL.appendingPathComponent("DB", isDirectory: true)
        try fileManager.createDirectory(at: databaseDirectoryURL, withIntermediateDirectories: true)
        return databaseDirectoryURL.appendingPathComponent("\(Self.salt(name: name)).sqlite").path
    }
    
    static func salt(name: String) -> String {
        return "db_\(name.sha1())_sqlite".sha1()
    }
}
