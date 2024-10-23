import Foundation

protocol APIClient {
    var session: URLSession { get }
}

extension APIClient {
    func performRequest<Response:Decodable>(url: String, headers: [(String, String)] = []) async throws -> Response {
        guard let url = URL(string: url) else { throw APIError.invalidUrl(url) }
        var request = URLRequest(url: url)
        headers.forEach { header in
            request.setValue(header.1, forHTTPHeaderField: header.0)
        }
        let response: Response = try await perform(request: request)
        return response
    }
    
    
    func fetchImage(movieId: String, language: String? = nil, includeImageLanguage: String? = nil) async throws -> ImageResponse {
            var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieId)/images")
            var queryItems = [URLQueryItem]()
            if let language = language {
                queryItems.append(URLQueryItem(name: "language", value: language))
            }
            if let includeImageLanguage = includeImageLanguage {
                queryItems.append(URLQueryItem(name: "include_image_language", value: includeImageLanguage))
            }
            components?.queryItems = queryItems

            guard let url = components?.url else { throw APIError.invalidUrl("Invalid URL") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhM2U2NmYxYzdhYTRiZWI5YjE4ZTNjOWNlY2IzMGQ2MiIsInN1YiI6IjY1NTFiYTI0NjdiNjEzNDVjZjAzOTQ5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VlzEzm91uDjmwRkHQfWAE16ZRHAUZqzmZoHMU_42z-0", forHTTPHeaderField: "Authorization")

            let response: ImageResponse = try await perform(request: request)
            return response
        }
    
    
    func fetchDetails(movieId: String, language: String? = nil, append_to_response: String? = nil) async throws -> DetailsResponse {
               var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieId)")
               var queryItems = [URLQueryItem]()
               if let language = language {
                   queryItems.append(URLQueryItem(name: "language", value: language))
               }
               if let append_to_response = append_to_response {
                   queryItems.append(URLQueryItem(name: "append_to_response", value: append_to_response))
               }
               components?.queryItems = queryItems

               guard let url = components?.url else { throw APIError.invalidUrl("Invalid URL") }
               var request = URLRequest(url: url)
               request.httpMethod = "GET"
               request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhM2U2NmYxYzdhYTRiZWI5YjE4ZTNjOWNlY2IzMGQ2MiIsInN1YiI6IjY1NTFiYTI0NjdiNjEzNDVjZjAzOTQ5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VlzEzm91uDjmwRkHQfWAE16ZRHAUZqzmZoHMU_42z-0", forHTTPHeaderField: "Authorization")

               let response: DetailsResponse = try await perform(request: request)
               return response
           }

    
    func fetchCredits(movieId: String, language: String? = nil, append_to_response: String? = nil) async throws -> CreditsResponse {
               var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits")
               var queryItems = [URLQueryItem]()
               if let language = language {
                   queryItems.append(URLQueryItem(name: "language", value: language))
               }
               guard let url = components?.url else { throw APIError.invalidUrl("Invalid URL") }
               var request = URLRequest(url: url)
               request.httpMethod = "GET"
               request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhM2U2NmYxYzdhYTRiZWI5YjE4ZTNjOWNlY2IzMGQ2MiIsInN1YiI6IjY1NTFiYTI0NjdiNjEzNDVjZjAzOTQ5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VlzEzm91uDjmwRkHQfWAE16ZRHAUZqzmZoHMU_42z-0", forHTTPHeaderField: "Authorization")

               let response: CreditsResponse = try await perform(request: request)
               return response
           }
    
    
    func getaccess<Response: Decodable>(url: String, body: [String: String]) async throws -> Response {
        guard let url = URL(string: url) else { throw APIError.invalidUrl(url) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        let response: Response = try await perform(request: request)
        return response
    }

    
    func perform<Response:Decodable>(request: URLRequest) async throws -> Response {
        let (data, response) = try await session.data(for: request)
        dump(String(data: data, encoding: .utf8))
        guard let http = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        guard http.statusCode == 200 else {
            switch http.statusCode {
            case 400...499:
                let body = String(data: data, encoding: .utf8)
                throw APIError.requestError(http.statusCode, body ?? "<no body>")
            case 500...599:
                throw APIError.serverError
            default: throw APIError.invalidStatusCode("\(http.statusCode)")
            }
        }
        do {
            let jsonDecoder = JSONDecoder()
           
            return try jsonDecoder.decode(Response.self, from: data)
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError)
        }
    }
}


