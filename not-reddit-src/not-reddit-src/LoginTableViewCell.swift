//
//  LoginTableViewCell.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 5/1/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift

class LoginTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionLogin(_ sender: Any) {
        try? OAuth2Authorizer.sharedInstance.challengeWithAllScopes()
    }
}
