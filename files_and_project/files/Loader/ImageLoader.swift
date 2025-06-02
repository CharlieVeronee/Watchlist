import Foundation
import SwiftUI

@Observable
class ImageLoader {
    let apiClient: ImageAPI
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: ImageResponse)
        case failed(error: Error)
    }
    
    init(apiClient: ImageAPI) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadImage(movieId: String) async {
        self.state = .loading
        do {
            let movieImage = try await apiClient.fetchImage(movieId: movieId)
            self.state = .success(data: movieImage)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
