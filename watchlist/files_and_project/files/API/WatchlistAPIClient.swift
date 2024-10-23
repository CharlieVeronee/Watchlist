import CoreLocation

protocol WatchlistAPI {
    func fetchWatchlist(code: String) async throws -> AllMovies
    
}

struct WatchlistAPIClient: WatchlistAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchWatchlist(code: String) async throws -> AllMovies {
        let headers = [
            ("Content-Type", "application/json"),
            ("Authorization", code),
            ("simkl-api-key", "c4c5d22b7196b110f4c57ec940021c4d8f2d87829ff010992a2ca8dc6d87bdb1")
        ]

        let allMovies: AllMovies = try await performRequest(url: "https://api.simkl.com/sync/all-items/movies/", headers: headers)
        return allMovies
    }
}

