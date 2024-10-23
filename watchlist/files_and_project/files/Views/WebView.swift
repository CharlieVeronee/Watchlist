import SwiftUI
import WebKit
import Foundation
import SwiftData

struct WebViewStruct: View {
    @Environment (\.modelContext) private var modelContext
    @State private var showPage = true
    private let urlString: String = "https://simkl.com/oauth/authorize?response_type=code&client_id=c4c5d22b7196b110f4c57ec940021c4d8f2d87829ff010992a2ca8dc6d87bdb1&redirect_uri=gitlab.oit.duke.edu/mbm80/watchlist"
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                showPage.toggle()
            } label: {
                Text("Open Website (TEST)")
            }
            .sheet(isPresented: $showPage) {
                WebView(url: URL(string: urlString)!, modelContext: modelContext, isPresented: $showPage)
            }
            Spacer()
            
        }.padding()
    }
}


struct WebView: UIViewRepresentable {
    var url: URL
    var modelContext: ModelContext
    @Binding var isPresented: Bool
    var useCode: ((String) -> Void)?
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if let urlString = webView.url?.absoluteString {
                print("Visited URL: \(urlString)")
                if urlString.prefix(65) == "https://simkl.com/oauth/gitlab.oit.duke.edu/mbm80/watchlist?code=" {
                    let code = String(urlString.dropFirst(65))
                    print("YAY: \(urlString.dropFirst(65))") //access code
                    parent.useCode?(code)
                    //User.create(code: code, context: parent.modelContext)
                    parent.isPresented = false
                    
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


//https://simkl.com/oauth/gitlab.oit.duke.edu/mbm80/watchlist?code=b9cc8a6b488778de54d47b61b20117aea18f545775a24f28bef1b155a0178162

#Preview {
    WebViewStruct()
    //this preview crashes
}
