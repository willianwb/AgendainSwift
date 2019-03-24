//
//  WebViewController.swift
//  Agenda
//
//  Created by Willian Bibow on 3/23/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var myURL: URL?

    @IBOutlet weak var webviewkit: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let myRequest = URLRequest(url: myURL!)
        webviewkit.load(myRequest)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webviewkit = WKWebView(frame: .zero, configuration: webConfiguration)
        webviewkit.uiDelegate = self
        view = webviewkit
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
