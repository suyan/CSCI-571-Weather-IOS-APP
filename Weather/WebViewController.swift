//
//  WebViewController.swift
//  Weather
//
//  Created by Su Yan on 12/9/15.
//  Copyright © 2015 suyan. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "http://forecast.io");
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
    }
}
