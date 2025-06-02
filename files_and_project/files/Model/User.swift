import Foundation
import SwiftData

@Model
class User: Identifiable {
    var myId: UUID
    var code: String?
    var firstname: String?
    var lastname: String?
    var isActive: Bool
    
    init(code: String? = nil, firstname: String? = nil, lastname: String? = nil, isActive: Bool = true) {
        self.myId = UUID()
        self.code = code
        self.firstname = firstname
        self.lastname = lastname
        self.isActive = isActive
    }
    
    static func create(code: String, context: ModelContext) {
        let user = User(code: code, isActive: true)
        context.insert(user)
    }
    
}

extension User {
    struct FormData: Identifiable {
        var id: UUID = UUID()
        var firstname: String = ""
        var lastname: String = ""
    }
    
    var dataForForm: FormData {
        FormData(
            id: myId,
            firstname: firstname ?? "",
            lastname: lastname ?? ""
        )
    }
    
    static func update(_ user: User, from formData: FormData) {
        user.firstname = formData.firstname.isEmpty ? nil : formData.firstname
        user.lastname = formData.lastname.isEmpty ? nil : formData.lastname
    }
}

extension User {
    static let previewData = [
        User(code: "058b284548fe860ccc483ed7533cea002bb1eab41a5c9ecd5b0e38f3fee63a15", firstname: "Meg", lastname: "Mahoney"),
        User(code: "c18fd959b7aa828a001bf9ea0282df175a2b940c8b42d57de91c2d61ece7272b", firstname: "JM", lastname: "Stroh"),
        User(code: "d9d06921d1e54dfcc78689434c62aaf9d99cd46b8608bfc9bd82a57b46ad0039", firstname: "Charlie", lastname: "Veronee")
    ]
}
