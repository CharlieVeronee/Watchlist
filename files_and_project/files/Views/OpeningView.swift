import Foundation
import SwiftUI
import SwiftData

struct OpeningView: View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \User.myId) private var users: [User]
    @State private var navigateToUsers = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("mainLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                Image("justColorTitle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                
                Spacer()
                
                NavigationLink(destination: LoggedInUsers(), isActive: $navigateToUsers) {
                    EmptyView()
                }
                
//                NavigationLink(destination: LoggedInUsers()) {
//                    Text("GO TO USERS")
//                        .foregroundColor(.white)
//                        .font(.title)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.darkBlueGray)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 50)
//                .padding(.leading, 50)
//                .padding(.trailing, 50)
//                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.1725490196, green: 0.2392156863, blue: 0.2862745098, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    navigateToUsers = true
                }
            }
        }
    }
}

#Preview {
    let preview = PreviewContainer([User.self])
    preview.add(items: User.previewData)
    return NavigationStack {
        OpeningView()
            .modelContainer(preview.container)
    }
}
