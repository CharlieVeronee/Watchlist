import Foundation
import SwiftData

struct CreditsResponse: Decodable {
    var crew: [crew]?
}

struct crew: Decodable, Hashable {
    var name: String?
    var job: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(job)
    }

    static func ==(lhs: crew, rhs: crew) -> Bool {
        return lhs.name == rhs.name && lhs.job == rhs.job
    }
}
