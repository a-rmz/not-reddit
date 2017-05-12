//
//  Web2ViewController.swift
//  not-reddit-src
//
//  Created by Emiliano García García on 12/05/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit

class Web2ViewController: UIViewController {
    
    var url: NSURL = NSURL()

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestObj = NSURLRequest(url: url as URL)
        self.webView.loadRequest(requestObj as URLRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
