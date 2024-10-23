import Foundation
import SwiftUI
import SwiftData

struct UserDetail: View {
    @Environment (\.modelContext) private var modelContext
    @Bindable var user: User
    @State private var isPresentingForm: Bool = false
    @State private var editFormData: User.FormData = User.FormData()
    
    
    
    var body: some View {
        ScrollView{
            VStack{
                if let firstname = user.firstname {
                    Text("\(firstname)'s account")
                        .font(.largeTitle)
                        .bold()
                        .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)}
                
                else if let lastname = user.lastname {
                    Text("\(lastname)'s account")
                        .font(.largeTitle)
                        .bold()
                        .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)}
                
                else {
                    Text("anonymous account")
                        .font(.largeTitle)
                        .bold()
                        .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)}
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                VStack {
                    
                    if let firstname = user.firstname {
                        Text(firstname)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .bold()
                        }
                    else {
                        Text("Add A First Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)}
                    Spacer()
                    Spacer()
                    if let lastname = user.lastname {
                        Text(lastname)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .bold()}
                    else {
                        Text("Add A Last Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)}
                }
//                Text("\(user.myId)")
//                if let code = user.code {
//                    Text(code)}
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                VStack {
                    Spacer()
                    Text("Active Status:")
                        .font(.title2)
                        .bold()
                    Text("toggle active status to include / exclude user data from results")
                        .multilineTextAlignment(.center)
                        .padding()
                    Toggle("Active Status", isOn: Bindable(user).isActive)
                        .tint(Color.pinkMain)
                        .fixedSize()
                        .font(.title2)
                    Spacer()
                }
                .background(Color.lightBlueGray)
                .cornerRadius(20)
                .shadow(color: Color.black, radius: 2, x: 0, y: 0)
                Spacer()
            }
            
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkBlueGray)
        .foregroundColor(.white)
        
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    editFormData = user.dataForForm
                    isPresentingForm.toggle()
                }
                .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $isPresentingForm) {
            NavigationStack {
                UserForm(user: $editFormData)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") { isPresentingForm.toggle() }
                                .foregroundColor(.lightBlueGray)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                User.update(user, from: editFormData)
                                isPresentingForm.toggle()
                            }
                            .foregroundColor(.lightBlueGray)
                        }
                    }
            }
        }
    }
}

#Preview {
    let preview = PreviewContainer([User.self])
    let user = User.previewData[1]
    return NavigationStack {
        UserDetail(user: user)
            .modelContainer (preview.container)
    }
}
