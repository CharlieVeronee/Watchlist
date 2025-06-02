import Foundation
import SwiftUI


struct UserRow: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var user: User
    
    var body: some View {
        HStack {
            if user.firstname == nil && user.lastname == nil {
                Text("Anonymous")
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            } else if let firstname = user.firstname {
                Text(firstname)
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            } else if let lastname = user.lastname {
                Text(lastname)
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            Spacer()
            Toggle("Active Status", isOn: $user.isActive)
                .tint(Color.pinkMain)
                .fixedSize()
        }
        .background(Color.lightBlueGray)
        .foregroundColor(.white)
        .padding()
    }
}

#Preview {
    let preview = PreviewContainer([User.self])
    let user = User.previewData[0]
    return NavigationStack {
        UserRow(user: user)
            .modelContainer (preview.container)
    }
}
