//
//  UserTableViewCell.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/31/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelLinkKarma: UILabel!
    @IBOutlet weak var labelCommentKarma: UILabel!

    @IBOutlet weak var logoutButtin: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.logoutButtin.isHidden = false
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    func setUserInfo(username: String, age: Int, linkKarma: Int, commentKarma: Int) {
        self.labelUsername.text = username
        self.labelAge.text = calculateAge(age: age)
        self.labelLinkKarma.text = String(linkKarma)
        self.labelCommentKarma.text = String(commentKarma)
    }

    func calculateAge(age: Int) -> String {
        return String(age)
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        NotSession.sharedSession.logout()
    }
}
