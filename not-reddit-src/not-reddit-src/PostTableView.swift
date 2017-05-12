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


class PostTableView: UITableViewController, askForLogin  {
    
    var urlActual: NSURL = NSURL()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        self.setDataSource()
    }
    
    override func viewDidLoad() {
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        }
    }
    
    var source: [reddift.Link] = []
    let session: Session = NotSession.sharedSession.session!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    func setDataSource() {
        

        let sub : Subreddit = Subreddit(subreddit: appDelegate.subreddit)
        do {
            try session.getList(Paginator(), subreddit: sub, sort: .hot, timeFilterWithin: .day, completion: { (result: Result<Listing>) in
                
                switch result {
                case .success(let value):
                    let children: [reddift.Link] = value.children as! [reddift.Link]
                    self.source = children
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
                
            })
        } catch { print(error) }

    }
    
    
    func tsToString(ts: Int) -> String {
        
        
        let start = NSDate.init(timeIntervalSince1970: TimeInterval(ts))
        
        let end = NSDate()
        
        let calendar = NSCalendar.current
        
        
        var datecomp = calendar.dateComponents(  [.year], from: start as Date, to: end as Date)
        
        if(datecomp.year!>0) {
            return "\(datecomp.year!) years ago"
        }
        
        
        datecomp = calendar.dateComponents(  [.month], from: start as Date, to: end as Date)
 
        
        if(datecomp.month!>0) {
            return "\(datecomp.month!) months ago"
        }
        
        
        datecomp = calendar.dateComponents(  [.day], from: start as Date, to: end as Date)
        
        if(datecomp.day!>0) {
            return "\(datecomp.day!) days ago"
        }
        
        datecomp = calendar.dateComponents(  [.hour], from: start as Date, to: end as Date)
        
        return "\(datecomp.hour!) hours ago"
        
    }
    
    func askForLogin() {
        let alert = UIAlertController(title: "Inicia sesión para acceder a esta función", message: "Para poder acceder a las funciones de votar o guardar inicia sesión en la pestaña de usuario", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let link: reddift.Link = self.source[indexPath.row]
        
        return (link.thumbnail.characters.count > 0) ? 297 :80;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PostTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        cell.delegate = self
    
        
        
        let link: reddift.Link = self.source[indexPath.row]
        cell.labelTitle.text = link.title
        cell.labelOp.text = "\(link.author) · \(tsToString(ts: link.created))· /r/\(link.subreddit)"
        
        cell.name = link.name
        
        
        if link.likes == VoteDirection.up {
            cell.buttonUp.imageView?.backgroundColor = UIColor.red
            cell.buttonDown.imageView?.backgroundColor = UIColor.white
        } else if link.likes == VoteDirection.down {
            cell.buttonDown.backgroundColor = UIColor.blue
            cell.buttonUp.backgroundColor = UIColor.white
        } else {
            cell.buttonDown.imageView?.backgroundColor = UIColor.white
            cell.buttonUp.imageView?.backgroundColor = UIColor.white
        }
        
        
        let url = URL.init(string: link.thumbnail)
        cell.imageViewThumb.layer.cornerRadius = 3
        cell.imageViewThumb.image = #imageLiteral(resourceName: "placeholder")
        cell.constraintImageHeight.constant = 0

        // Async management of the images
        if url != nil{
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if data != nil{
                        cell.constraintImageHeight.constant = 198
                        cell.imageViewThumb.image = UIImage(data: data!)
                        cell.layoutSubviews()
                    }
                }
            }
        }

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.source[indexPath.row].url)
        
            self.urlActual = NSURL.init(string: self.source[indexPath.row].url)!
            
            performSegue(withIdentifier: "webSegue", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebViewController
        vc.url = self.urlActual
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.setDataSource()
        }
    }
    
}





