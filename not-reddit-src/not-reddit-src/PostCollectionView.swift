//
//  PostCollectionView.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/23/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit

class PostCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let datasource: [String] = ["Title 1", "Title 2"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("hi")
        return self.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        cell.title.text = "HI"
        cell.layoutIfNeeded()
        return cell
    }

    
}
