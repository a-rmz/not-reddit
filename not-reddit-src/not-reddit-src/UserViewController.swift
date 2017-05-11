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
    var currentUser: Account? = NotSession.sharedSession.currentUser
    
    @IBOutlet weak var tableViewUser: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        currentUser = NotSession.sharedSession.currentUser
        tableViewUser.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewUser.dataSource = self
        tableViewUser.delegate = self
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if NotSession.sharedSession.loggedIn {
            return 290
        } else {
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NotSession.sharedSession.refreshSession()
        currentUser = NotSession.sharedSession.currentUser
        if NotSession.sharedSession.loggedIn {
            let cell: UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell

            cell.setUserInfo(
                username: self.currentUser!.name,
                age: self.currentUser!.created,
                linkKarma: self.currentUser!.linkKarma,
                commentKarma: self.currentUser!.commentKarma
            )
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "nouser", for: indexPath) as! LoginTableViewCell
        }
    }

    

}
