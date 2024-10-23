import Foundation
import SwiftUI

@Observable
class DetailsLoader {
    let apiClient: DetailsAPI
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: DetailsResponse)
        case failed(error: Error)
    }
    
    init(apiClient: DetailsAPI) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadDetails(movieId: String) async {
        self.state = .loading
        do {
            let movieDetails = try await apiClient.fetchDetails(movieId: movieId)
            self.state = .success(data: movieDetails)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
