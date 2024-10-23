import Foundation
import SwiftUI

@Observable
class WatchlistLoader {
    let apiClient: WatchlistAPI
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: [MovieItem]) 
        case failed(error: Error)
    }
    
    init(apiClient: WatchlistAPI) {
        self.apiClient = apiClient
    }

    @MainActor
    func loadWatchlistData(codes: [String]) async {
        self.state = .loading
        var allMoviesAggregate = [MovieItem]()
        for code in codes {
            do {
                let watchlist = try await apiClient.fetchWatchlist(code: "Bearer \(code)")
                
                let updatedMovies = watchlist.movies.map { movieItem -> MovieItem in
                    
                    return MovieItem(last_watched_at: movieItem.last_watched_at,
                                     status: movieItem.status,
                                     user_rating: movieItem.user_rating,
                                     movie: movieItem.movie,
                                     access_token: code)
                }
                allMoviesAggregate.append(contentsOf: updatedMovies)
            } catch {
                self.state = .failed(error: error)
                return
            }
        }
        
        self.state = .success(data: allMoviesAggregate)
    }
}
