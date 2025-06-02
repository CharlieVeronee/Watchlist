import Foundation
import SwiftData

struct AllMovies: Decodable {
    var movies: [MovieItem]
    
    static func mock() -> AllMovies {
        AllMovies(movies: [
            MovieItem(last_watched_at: "2023-10-10T00:00:00Z", status: "completed", user_rating: 9, movie: Movie(title: "The Darjeeling Limited", year: 2007, ids: MovieIDs(simkl: 58252, tmdb: "58252")), access_token: "058b284548fe860ccc483ed7533cea002bb1eab41a5c9ecd5b0e38f3fee63a15"),
            MovieItem(last_watched_at: "2023-10-19T00:00:00Z", status: "completed", user_rating: 7, movie: Movie(title: "Rushmore", year: 1998, ids: MovieIDs(simkl: 65982, tmdb: "58252")), access_token: "058b284548fe860ccc483ed7533cea002bb1eab41a5c9ecd5b0e38f3fee63a15"),
            MovieItem(last_watched_at: "2023-10-19T00:00:00Z", status: "plantowatch", user_rating: 1, movie: Movie(title: "Jurassic Lit", year: 2024, ids: MovieIDs(simkl: 696969, tmdb: "58252")), access_token: "058b284548fe860ccc483ed7533cea002bb1eab41a5c9ecd5b0e38f3fee63a15")
        ])
    }
}

struct MovieItem: Decodable, Identifiable {
    let last_watched_at: String?
    let status: String?
    let user_rating: Int?
    var movie: Movie
    let access_token: String?
    
    var id: String {
           if let token = access_token {
               return "\(movie.ids.simkl)_\(token)"
           } else {
               return "\(movie.ids.simkl)_noToken"
           }
       }
}

struct Movie: Identifiable, Decodable {
    var title: String
    var year: Int?
    
    var ids: MovieIDs
    
    var id: Int {
        return ids.simkl
    }
}

struct MovieIDs: Decodable {
    var simkl: Int
    var tmdb: String
}

extension AllMovies {
    mutating func append(movies: [MovieItem]) {
        self.movies.append(contentsOf: movies)
    }
}
