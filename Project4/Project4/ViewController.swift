//
//  ViewController.swift
//  Project4
//
//  Created by 원현식 on 2020/02/10.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Properties
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "microsoft.com"]
    
    // loadView() gets called before viewDidLoad() it makes sense to position the code above it too.
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let goBackButton = UIBarButtonItem(title: "←", style: .plain , target: webView, action: #selector(webView.goBack))
        let goForwardButton = UIBarButtonItem(title: "→", style: .plain, target: webView, action: #selector(webView.goForward))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [goBackButton, goForwardButton, spacer, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        // This line enables a property on the web view that allows users to swipe from the left or right edge to move backward or forward in their web browsing. This is a feature from the Safari browser that many users rely on, so it's nice to keep it around.
        webView.allowsBackForwardNavigationGestures = true
    }
    
    //MARK: - Observer
    // Once you have registered as an observer using KVO, you must implement a method called observeValue().
    // This tells you when an observed value has changed,
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.isHidden = false
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //MARK: - Private Methods
    @objc private func openTapped() {
        let ac = UIAlertController(title: "Open page..", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    // actionSheet에서 버튼이 눌렸을때 호출.
    private func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
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
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
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

//MARK: - addObserver Method란
/*
 The addObserver() method takes four parameters
 1. who the observer is (we're the observer, so we use self)
 2. what property we want to observe (we want the estimatedProgress property of WKWebView)
 3. which value we want (we want the value that was just set, so we want the new one)
 4. and a context value.
 */

