//
//  NAWebViewController.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import UIKit
import WebKit

final class NAWebViewController: UIViewController, WKNavigationDelegate {
    
    var urlString: String?
    var webView             = WKWebView()
    let activityIndicator   = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        
        configureWebView()
        webView.navigationDelegate = self
        view = self.webView
        
        addActivityIndicator(on: webView)
    }
    
    func configureWebView() {
        if let url = URL(string: urlString ?? "") {
            let request = URLRequest(url: url)
            self.webView.load(request)
        } else {
            self.presentGFAlertOnMainThread(title: "Error", message: "site not found", buttonTitle: "ok")
        }
        self.webView.allowsBackForwardNavigationGestures = true
    }

    
    /// add indicator on view
    /// - Parameter view: webView
    func addActivityIndicator(on view: UIView) {
        view.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.style = .large
        self.activityIndicator.color = .black
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.activityIndicator.startAnimating()
    }
    
    
    //MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "ok")
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "ok")
        activityIndicator.stopAnimating()
    }
    
}
