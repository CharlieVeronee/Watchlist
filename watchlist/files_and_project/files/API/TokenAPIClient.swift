import CoreLocation
protocol AccessTokenAPI {
    func fetchToken(code: String) async throws -> TokenResponse
    
}

struct AccessTokenAPIClient: AccessTokenAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchToken(code: String) async throws -> TokenResponse {
        let body = [
            "code": code,
            "client_id": "c4c5d22b7196b110f4c57ec940021c4d8f2d87829ff010992a2ca8dc6d87bdb1",
            "client_secret": "1013df09a334e5d19a2fc32adf03dae2a1ea1253cdfe46cc84a0a7762f58be5b",
            "redirect_uri": "gitlab.oit.duke.edu/mbm80/watchlist",
            "grant_type": "authorization_code"
        ]

        let response: TokenResponse = try await getaccess(url: "https://api.simkl.com/oauth/token", body: body)
        return response
    }
}
