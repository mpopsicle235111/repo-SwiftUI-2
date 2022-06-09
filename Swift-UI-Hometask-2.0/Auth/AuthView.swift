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
                URLQueryItem(name: "client_id", value: "8188132"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                //The scope value defines the permissions you have to read user data.
                //It is a combined sum of values, forming a total number by addition
                //In this case 270406 = 2 (friends) + 4 (photos) + 64 (stories) + 8192 (wall) + 262144 (groups)
                //App is allowed to get friens, photos, stories and groups
                //A full list:
                //notify (+1)    User allowed to send notifications to him/her (for Flash/iFrame apps).
                //friends (+2)    Access to friends.
                //photos  (+4)    Access to photos.
                //audio   (+8)    Access to audio.
                //video  (+16)    Access to video.
                //stories (+64)    Access to stories.
                //pages  (+128)    Access to wiki pages.
                // +256    Addition of link to the application in the left menu.
                //status  (+1024)    Access to user status.
                //notes   (+2048)    Access to notes.
                //messages  (+4096)    (for Standalone applications) Access to advanced methods for messaging.
                //wall     (+8192)    Access to standard and advanced methods for the wall. Note that this access permission is unavailable for sites (it is ignored at attempt of authorization).
                //ads  (+32768)    Access to advanced methods for Ads API.
                //offline  (+65536)    Access to API at any time (you will receive expires_in = 0 in this case).
                //docs  (+131072)    Access to docs.
                //groups (+262144)    Access to user communities.
                //notifications  +524288) Acc. to notifications about answers to user.
                //stats (+1048576)    Access to statistics of user groups and applications where he/she is an administrator.
                //email (+4194304)    Access to user email.
                //market  (+134217728)    Access to market.
                URLQueryItem(name: "scope", value: "270406"),
                //MARK: IN ORDER TO HAVE ACCESS TO NEWSFEED
                //one needs access BOTH to Friends AND WALL
                //permitted in Authentification Controller
                //This is a weird trick by VK
                
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
