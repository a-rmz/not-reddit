//
//  UserViewController.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/12/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let session = NotSession.sharedSession.session
    var currentUser: Account? = nil
    
    @IBOutlet weak var tableViewUser: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewUser.dataSource = self
        tableViewUser.delegate = self
        loadAccount()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        try? OAuth2Authorizer.sharedInstance.challengeWithScopes(["mysubreddits", "identity"])
    }
    
    func loadAccount() {
        do {
           try session?.getProfile({ (resultAccount: Result<Account>) in
                self.currentUser = resultAccount.value
            })
        } catch {
            try? OAuth2Authorizer.sharedInstance.challengeWithScopes(["mysubreddits", "identity"])
            print("no account")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = UserTableViewCell()
        
        do {
            try session!.getProfile({ (resultAccount: Result<Account>) in
                self.currentUser = resultAccount.value
                
                cell.setUserInfo(
                    username: (self.currentUser?.name)!,
                    age: (self.currentUser?.created)!,
                    linkKarma: (self.currentUser?.linkKarma)!,
                    commentKarma: (self.currentUser?.commentKarma)!
                )
                
            })
            return cell
        } catch {
            print("no account")
        }
        
        return UITableViewCell()
    }

    

}
