//
//  PostTableView.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/23/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift
import Foundation

class PostTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var source: [reddift.Link] = []
    let session: Session = NotSession.sharedSession.session!
    let paginator: Paginator = Paginator()
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        setDataSource()
    }
    
    func setDataSource() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let sub : Subreddit = Subreddit(subreddit: appDelegate.subreddit)
        do {
            try session.getList(Paginator(), subreddit: sub, sort: .hot, timeFilterWithin: .day, completion: { (result: Result<Listing>) in
                
                switch result {
                case .success(let value):
                    let children: [reddift.Link] = value.children as! [reddift.Link]
                    self.source = children
                    self.reloadData()
//                    for child in children {
//                        print (child.title)
//                    }
                case .failure(let error):
                    print(error)
                }
                
            })
        } catch { print(error) }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        cell.buttonUp.imageView!.tintColor = UIColor.orange
        
        let link: reddift.Link = self.source[indexPath.row]
        cell.labelTitle.text = link.title
        cell.labelOP.text = "\(link.author) · \(tsToString(ts: link.created))· /r/\(link.subreddit)"
    
        //print(JSONStringify(value: link as AnyObject, prettyPrinted: true))
        print("")
        print("")
        

        let url = URL.init(string: link.thumbnail)
        
        // Async management of the images
        if url != nil{
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if data != nil{
                
                    cell.imageViewThumb.image = UIImage(data: data!)
                }
                
            }
        }
        }

        return cell
    }
    
    func tsToString(ts: Int) -> String {
        return "some time ago"
        
    }
    

}
