//
//  ContentView.swift
//  ios-client-server-1347
//
//  Created by Олег on 06.07.2021.
//

import SwiftUI
import WebKit
import Alamofire


struct WebView : UIViewRepresentable {
    let request: URLRequest
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct ContentView: View {
    var body: some View {
        
        WebView( request: URLRequest(url: URL(string: "https://oauth.vk.com")!))
    }
}

//struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
//                    .padding()
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
