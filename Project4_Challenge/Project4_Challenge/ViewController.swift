//
//  ViewController.swift
//  Project4_Challenge
//
//  Created by 원현식 on 2020/02/14.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var website: String?
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let goBackButton = UIBarButtonItem(title: "←", style: .plain , target: webView, action: #selector(webView.goBack))
        let goForwardButton = UIBarButtonItem(title: "→", style: .plain, target: webView, action: #selector(webView.goForward))
        
        toolbarItems = [goBackButton, goForwardButton, spacer, progressButton,spacer]
        navigationController?.isToolbarHidden = false
        
        if let website = website {
            let url = URL(string: "https://" + website)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.isHidden = false
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        progressView.isHidden = true
        
    }
    
    // This delegate callback allows us to decide whether we want to allow navigation to happen or not every time something happens.
    // should we load the page or should we not?
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host { // domain. ex) apple.com
            if host.contains(website!) {
                decisionHandler(.allow)
                return
            }
            
            let ac = UIAlertController(
                title: "Restricted website",
                message: "The site located at \(host) is not allowed",
                preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        decisionHandler(.cancel)
    }
}

