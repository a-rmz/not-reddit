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
        NotSession.sharedSession.refreshSession()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell?
        
//        try? session!.getProfile({
//        (result: Result<Account>) in
//            print(result)
//            switch result {
//            case .failure(let error):
//                cell = tableView.dequeueReusableCell(withIdentifier: "nouser", for: indexPath) as! LoginTableViewCell
//                print(error)
//                
//            case .success(let account):
//                self.currentUser = account
//                cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
//                
//                let cellUser = cell as! UserTableViewCell
//                
//                cellUser.setUserInfo(
//                    username: self.currentUser!.name,
//                    age: self.currentUser!.created,
//                    linkKarma: self.currentUser!.linkKarma,
//                    commentKarma: self.currentUser!.commentKarma
//                )
//            }
//        })
        
        if currentUser != nil {
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
