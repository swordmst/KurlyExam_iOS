//
//  WebView.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/14/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var link: String?
    public let webView: WKWebView
    
    public init(_ link: String?, webView: WKWebView = WKWebView()) {
        self.link = link
        self.webView = webView
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = link, let url = URL(string: url) else {
            return webView
        }
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}

#Preview {
    WebView("https://www.kurly.com/")
}
