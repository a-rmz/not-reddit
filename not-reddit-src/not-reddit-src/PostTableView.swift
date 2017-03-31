//
//  PostTableView.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/23/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift

class PostTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var source: [String] = ["Hi", "There"]
    let session: Session = NotSession.sharedSession.session!
    let paginator: Paginator = Paginator()
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        setDataSource()
    }
    
    func setDataSource() {
//        let sub : Subreddit = Subreddit(subreddit: "birdsforscale")
//        do {
//            try session.getList(Paginator(), subreddit: sub, sort: .hot, timeFilterWithin: .day, completion: { (result: Result<Listing>) in
//                let list = result.value
//                let values = list?.children
//                let links: [Link] = [Link(id: (values?.first?.id)!)]
//                
//                try? self.session.getLinksById(links, completion: { (result) -> Void in
//                    switch result {
//                    case .failure(let error):
//                        print(error)
//                    case .success(let listing):
//                        listing.children.flatMap { $0 as? Link }.forEach { print($0.title) }
//                    }
//                })
//                
//            })
//        } catch { print(error) }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        cell.buttonUp.imageView!.tintColor = UIColor.orange
        cell.labelTitle.text = "Hi"
        return cell
    }
    
    

}
