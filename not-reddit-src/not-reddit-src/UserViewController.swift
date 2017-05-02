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
    var currentUser: Account?
    
    @IBOutlet weak var tableViewUser: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        loadAccount()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewUser.dataSource = self
        tableViewUser.delegate = self
    }
    
    func loadAccount() {
        try? session!.getProfile({
            (result: Result<Account>) in
            
            switch result {
            case .failure(_):
                try? OAuth2Authorizer.sharedInstance.challengeWithScopes(["mysubreddits", "identity"])
                
            case .success(_):
                print("yay")
            }
        })

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
        var loginCell: LoginTableViewCell = LoginTableViewCell()
        var userCell: UserTableViewCell = UserTableViewCell()
        var isUserCell: Bool = false
        
        try? session!.getProfile({
        (result: Result<Account>) in
                
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let account):
                self.currentUser = account
                userCell.setUserInfo(
                    username: account.name,
                    age: account.created,
                    linkKarma: account.linkKarma,
                    commentKarma: account.commentKarma
                )
                isUserCell = true
            }
        })
        
        if isUserCell {
            return userCell
        } else {
            print("heh")
            return loginCell
        }
    }

    

}
