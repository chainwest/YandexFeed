//
//  WebViewController.swift
//  YandexFeed
//
//  Created by Evgeniy on 13.02.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var link = ""

    @IBOutlet weak var webViewer: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webViewer.uiDelegate = self
        
        let myURL = URL(string: link)
        let request = URLRequest(url: myURL!)
        webViewer.load(request)
    }
}
