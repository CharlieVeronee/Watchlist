import Foundation

protocol CreditsAPI {
    func fetchCredits(movieId: String) async throws -> CreditsResponse
}

struct CreditsAPIClient: CreditsAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchCredits(movieId: String) async throws -> CreditsResponse {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidUrl("Invalid URL: \(urlString)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhM2U2NmYxYzdhYTRiZWI5YjE4ZTNjOWNlY2IzMGQ2MiIsInN1YiI6IjY1NTFiYTI0NjdiNjEzNDVjZjAzOTQ5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VlzEzm91uDjmwRkHQfWAE16ZRHAUZqzmZoHMU_42z-0", forHTTPHeaderField: "Authorization")

        let response: CreditsResponse = try await perform(request: request)
        return response
    }
}
