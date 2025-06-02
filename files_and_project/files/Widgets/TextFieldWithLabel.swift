import SwiftUI

struct TextFieldWithLabel: View {
  let label: String
  @Binding var text: String
  var prompt: String? = nil

  var body: some View {
    VStack(alignment: .leading) {
        Text(label)
            .font(.title3)
            .foregroundColor(.lightBlueGray)
        .modifier(FormLabel())
        
      TextField(label, text: $text, prompt: promptText())
            .font(.title3)
            .foregroundColor(.lightBlueGray)
        .padding(.bottom, 20)
    }
  }

  func promptText() -> Text? {
    if let prompt {
      return Text(prompt)
    } else {
      return nil
    }
  }
}

struct FormLabel: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .font(.caption)
  }
}

#Preview {
  TextFieldWithLabel(label: "Name", text: Binding.constant("Jon Phillips"), prompt: "Enter a name already!")
    .padding()
}
