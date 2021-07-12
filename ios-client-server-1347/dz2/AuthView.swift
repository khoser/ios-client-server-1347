//
//  ContentView.swift
//  ios-client-server-1347
//
//  Created by Олег on 06.07.2021.
//

import SwiftUI
import WebKit


struct WebView : UIViewRepresentable  {
    let request: URLRequest

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func makeUIView(context: Context) -> WKWebView  {
        //let vc = ViewController()
        let ww = WKWebView()
        //ww.navigationDelegate = vc
        return ww
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        uiView.load(self.request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // Delegate methods go here
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
            }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
                }
            
            guard let token = params["access_token"], let userid =  params["user_id"] else {
                decisionHandler(.cancel)
                return
            }
            
            print(token)
            
            Session.session.userId = Int(userid)!
            Session.session.token = token
            Session.session.authorized = 1
            decisionHandler(.cancel)
            
            parent.presentationMode.wrappedValue.dismiss()
            
        }
        // alert functionality goes here
    }
}



struct AuthView: View {
    
    var body: some View {
        
        let request = VKAuthService(Session.session.client_id).request()
        
        WebView( request: request)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
