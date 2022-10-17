//
//  WebViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/01.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBAction func tapCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: Constant.moreURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
