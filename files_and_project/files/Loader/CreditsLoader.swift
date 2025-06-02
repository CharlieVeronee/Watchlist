import Foundation
import SwiftUI

@Observable
class CreditsLoader {
    let apiClient: CreditsAPI
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: CreditsResponse)
        case failed(error: Error)
    }
    
    init(apiClient: CreditsAPI) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadCredits(movieId: String) async {
        self.state = .loading
        do {
            let movieCredits = try await apiClient.fetchCredits(movieId: movieId)
            self.state = .success(data: movieCredits)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
