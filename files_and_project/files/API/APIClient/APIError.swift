import Foundation

enum APIError : LocalizedError {
    case invalidUrl(String)
    case networkingError(Error)
    case serverUnavailable(Error)
    case resourceError(String)
    case serverError // HTTP 5xx
    case requestError(Int, String) // HTTP 4xx
    case invalidResponse
    case invalidStatusCode(String)
    case decodingError(DecodingError)
    case unauthenticated
    case failed
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl(let string): return "Invalid Url: \(string)"
        case .networkingError(let error): return "Error sending request: \(error.localizedDescription)"
        case .serverUnavailable(let error): return "Server unavailable: \(error.localizedDescription). Please make sure you are connected to the network."
        case .resourceError(let message): return message
        case .serverError: return "HTTP 500 Server Error"
        case .requestError(let status, let body): return "HTTP \(status)\n\(body)"
        case .invalidResponse: return "Invalid Response"
        case .invalidStatusCode(let string): return "Unhandled HTTP status code: \(string)"
        case .decodingError(let error): return "Decoding error: \(error)"
        case .unauthenticated: return "Please sign in"
        case .failed: return "Unknown or unhandled status code"
        }
    }
}
