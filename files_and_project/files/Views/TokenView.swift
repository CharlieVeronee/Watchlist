import Foundation
import SwiftUI

struct TokenView: View {
    let TokenLoader: TokenLoader
    var input: String = "9c8eb982daea26f2149d9790d742a7f5552641d5d83931e1e19c63a08f85624a"
    
    var body: some View {
        VStack {
            Spacer()
            Button("Get Token") {
                Task {
                    await TokenLoader.loadAccessToken(code: input)
                }
                
            }
            .buttonStyle(.borderedProminent)
            
            
            Spacer()
            switch TokenLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): ScrollView { Text("Error \(error.localizedDescription)") }
            case .success(let token):
                TokenDisplay(token: token)
            }
        }
        .task { await TokenLoader.loadAccessToken(code: input)
        }
    }
}

struct TokenDisplay: View {
    let token: TokenResponse
    
    var body: some View {
        Text(token.access_token)
        Text(token.token_type)
        Text(token.scope)
    }
}

#Preview {
    TokenView(TokenLoader: TokenLoader(apiClient: AccessTokenAPIClient()))
}


