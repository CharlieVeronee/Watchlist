import Foundation
import SwiftUI
import SwiftData

struct LoggedInUsers: View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \User.firstname) private var users: [User]
    
    @State private var showPage = false
    private let urlString: String = "https://simkl.com/oauth/authorize?response_type=code&client_id=c4c5d22b7196b110f4c57ec940021c4d8f2d87829ff010992a2ca8dc6d87bdb1&redirect_uri=gitlab.oit.duke.edu/mbm80/watchlist"
    
    var body: some View {
        
            VStack {
                Spacer()
                Image("justColorTitle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                Spacer()
                Spacer()
                Text("Logged In Users")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                List(users) { user in
                    NavigationLink(destination: UserDetail(user: user)) {
                            UserRow(user: user)
                                .swipeActions {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                modelContext.delete(user)
                                            }
                                        }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 20)
                            
                        
                        .background(Color.lightBlueGray)
                        .cornerRadius(10)
                        .padding(.vertical, 8)
                    }
                    //.buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 20)
                Button("ADD A USER") {
                    showPage.toggle()
                }
                .sheet(isPresented: $showPage) {
                    WebView(url: URL(string: urlString)!, modelContext: modelContext, isPresented: $showPage, useCode: useCode)}
                .foregroundColor(.white)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.lightBlueGray)
                .cornerRadius(10)
                .padding(.leading, 25)
                .padding(.trailing, 25)
                .bold()
                
                NavigationLink(destination: WatchlistJoint(
                    watchlistLoader: WatchlistLoader(apiClient: WatchlistAPIClient()),
                    codes: users.filter { $0.isActive }.compactMap { $0.code },
                    activeUserNames: users.filter { $0.isActive }.compactMap { user in
                        if let firstname = user.firstname, let lastname = user.lastname {
                            return "\(firstname) \(lastname)"
                        } else if let firstname = user.firstname {
                            return firstname
                        } else if let lastname = user.lastname {
                            return lastname
                        } else {
                            return "Anonymous"
                        }
                    }
                ))
                {
                    Text("JOINT WATCHLIST")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.lightBlueGray)
                        .cornerRadius(10)
                        .bold()
                }
                .padding(.leading, 25)
                .padding(.trailing, 25)
                
                NavigationLink(destination: Intermediate(
                    watchlistLoader: WatchlistLoader(apiClient: WatchlistAPIClient()),
                    codes: users.filter { $0.isActive }.compactMap { $0.code },
                    activeUserNames: users.filter { $0.isActive }.compactMap { user in
                        if let firstname = user.firstname, let lastname = user.lastname {
                            return "\(firstname) \(lastname)"
                        } else if let firstname = user.firstname {
                            return firstname
                        } else if let lastname = user.lastname {
                            return lastname
                        } else {
                            return "Anonymous"
                        }
                    }
                ))
                {
                    Text("WATCHDLIST")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.lightBlueGray)
                        .cornerRadius(10)
                        .bold()
                }
                .padding(.leading, 25)
                .padding(.trailing, 25)

                
            }
            .onAppear {
                if users.isEmpty {
                    for user in User.previewData {
                        modelContext.insert(user)
                    }
                }
                
                
            //.navigationTitle("WATCHLIST")
        }
        .background(.darkBlueGray)
        
        
        
    }
    
    func useCode(code: String) {
        Task {
            let tokenLoader = TokenLoader(apiClient: AccessTokenAPIClient())
            await tokenLoader.loadAccessToken(code: code)
            if case .success(let tokenResponse) = tokenLoader.state {
                User.create(code: tokenResponse.access_token, context: modelContext)
            }
        }
    }
    
}



#Preview {
    let preview = PreviewContainer([User.self])
    preview.add(items: User.previewData)
    return NavigationStack {
        LoggedInUsers()
            .modelContainer(preview.container)
    }
}
