//
//  Session.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/12/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import reddift

class NotSession {
    
    /**
      * Shared instance
      */
    static let sharedSession = NotSession()
    var session: Session?
    
    init() {
        session = loadSession()
    }
    
    private func loadSession() -> Session? {
        let names: [String] = OAuth2TokenRepository.savedNames
        if names.count > 0, let token: OAuth2Token = try? OAuth2TokenRepository.token(of: names[0]) {
            let session: Session = Session(token: token)
            
            return session
        }
        return Session()
    }
    
}
