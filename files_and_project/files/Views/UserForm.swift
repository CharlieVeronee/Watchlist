import SwiftUI

struct UserForm: View {
  @Binding var user: User.FormData

  var body: some View {
    Form {
        TextFieldWithLabel(label: "First Name", text: $user.firstname, prompt: "Enter a First Name")
        TextFieldWithLabel(label: "Last Name", text: $user.lastname, prompt: "Enter a Last Name")
    }
  }
}
