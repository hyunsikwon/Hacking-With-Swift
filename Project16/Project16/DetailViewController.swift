//
//  DetailViewController.swift
//  Project16
//
//  Created by 원현식 on 2020/03/20.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var capital: Capital?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let capital = capital, let city = capital.title {
            title = city
            if let url = URL(string: "https://en.wikipedia.org/wiki/" + city) {
                webView.load(URLRequest(url: url))
                // This line enables a property on the web view that allows users to swipe from the left or right edge to move backward or forward in their web browsing. This is a feature from the Safari browser that many users rely on, so it's nice to keep it around.
                webView.allowsBackForwardNavigationGestures = true
            }
            
        }
        
        
    }
    
    
}
