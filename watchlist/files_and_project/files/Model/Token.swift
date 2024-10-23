import Foundation
import SwiftData

struct TokenResponse: Decodable {
    var access_token: String
    var token_type: String
    var scope: String
}

class WatchlistCache {
    static let shared = WatchlistCache()
    private var loadedTokens: Set<String> = []

    func isLoaded(token: String) -> Bool {
        return loadedTokens.contains(token)
    }

    func setLoaded(token: String) {
        loadedTokens.insert(token)
    }
}
