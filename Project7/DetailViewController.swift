//
//  DetailViewController.swift
//  Project7
//
//  Created by Anna Shark on 6/9/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else {return}
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 125%; margin: 50px; text-align: justify} </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }

}
