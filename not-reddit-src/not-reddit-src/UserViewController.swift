//
//  UserViewController.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/12/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift

class UserViewController: UIViewController {
    
    let session = NotSession.sharedSession.session
    var currentUser: Account? = nil
    
    @IBOutlet weak var labelCommentKarma: UILabel!
    @IBOutlet weak var labelLinkKarma: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAccount()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        try? OAuth2Authorizer.sharedInstance.challengeWithScopes(["mysubreddits", "identity"])
    }
    
    func loadAccount() {
        try! session?.getProfile({ (resultAccount: Result<Account>) in
            self.currentUser = resultAccount.value!
                
            self.labelCommentKarma.text = String(self.currentUser!.commentKarma)
            self.labelLinkKarma.text = String(self.currentUser!.linkKarma)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
