import Foundation
import SwiftUI

@Observable
class TokenLoader {
    let apiClient: AccessTokenAPI
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: TokenResponse)
        case failed(error: Error)
    }
    
    init(apiClient: AccessTokenAPI) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadAccessToken(code: String) async {
        self.state = .loading
        do {
            let token = try await apiClient.fetchToken(code: code)
            self.state = .success(data: token)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
