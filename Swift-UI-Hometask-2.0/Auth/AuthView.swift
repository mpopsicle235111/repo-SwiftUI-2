//
//  AuthView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 17.05.2022.
//

import SwiftUI
import WebKit
import Combine //This is for AnyCancellable

struct AuthView: UIViewRepresentable {
    var completedSuccessfully: () -> Void
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private var urlComponents: URLComponents = {
        var request = URLComponents()
            request.scheme = "https"
            request.host = "oauth.vk.com"
            request.path = "/authorize"
            request.queryItems = [
                URLQueryItem(name: "client_id", value: "7822904"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                URLQueryItem(name: "scope", value: "262150"),
                URLQueryItem(name: "response_type", value: "token"),
                URLQueryItem(name: "revoke", value: "1"),
                URLQueryItem(name: "v", value: "5.68")
            ]
            
            return request
    }()
    
    init(completion: @escaping () -> Void) {
        completedSuccessfully = completion
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.navigationDelegate = context.coordinator
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context _: Context) {
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AuthView
        var webViewNavigationSubscriber: AnyCancellable?
        
        
        init(_ uiWebView: AuthView) {
            parent = uiWebView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(
            _: WKWebView,
            decidePolicyFor navigationResponse: WKNavigationResponse,
            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
        ) {
            guard
                let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment
            else { return decisionHandler(.allow) }
            
            let parameters = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, params in
                    var dict = result
                    let key = params[0]
                    let value = params[1]
                    dict[key] = value
                    return dict
                }
            guard
                let token = parameters["access_token"],
                let userIDString = parameters["user_id"],
                let userID = Int(userIDString)
            
            else { return decisionHandler(.allow) }
            
            if token.count > 0 && userID > 0 {
                Session.shared.token = token
                Session.shared.userId = userIDString
                parent.completedSuccessfully()
                
            }
            
            decisionHandler(.cancel)
            
        }
        
    }
    
}

extension AuthView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ : WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "iOSNative" {
            if let body = message.body as? [String: Any?] {
                print("JSON returned by the server: \(body)")
            } else if let body = message.body as? String {
                print("JSON returned by the server: \(body)")
            }
        }
    }
}
