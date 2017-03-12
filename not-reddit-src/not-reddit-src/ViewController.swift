//
//  ViewController.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/5/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func actionAuth(_ sender: Any) {
        try? OAuth2Authorizer.sharedInstance.challengeWithScopes(["mysubreddits", "identity"])
    }
    
    @IBAction func actionRetreive(_ sender: Any) {
        let savedNames: [String] = OAuth2TokenRepository.savedNames
        
        for name in savedNames {
            print(name)
        }
        
        let token = try? OAuth2TokenRepository.token(of: savedNames[0])
        let session = Session(token: token!)
        
        try? session.getProfile { (resultAccount: Result<Account>) in
            let account = resultAccount.value!
            
            print(account.name)
            print("link karma: \(account.linkKarma)")
            print("comment karma: \(account.commentKarma)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

