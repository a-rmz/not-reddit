//
//  FavoritesTableViewController.swift
//  not-reddit-src
//
//  Created by Emiliano García García on 12/05/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift
import Foundation

class FavoritesTableViewController: UITableViewController, askForReload {

    var source: [reddift.Link] = []
    
    var urlActual: NSURL = NSURL()
    
    let session: Session = NotSession.sharedSession.session!
    
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setDataSource() {
        
        
        if NotSession.sharedSession.currentUser != nil{
        
        do {
            try session.getUserContent((NotSession.sharedSession.currentUser?.name)!, content: .saved, sort: .new, timeFilterWithin: .all, paginator: Paginator()) { (result: Result<Listing>) in
                switch result {
                    
                case .success(let value):
                    let children: [reddift.Link] = value.children as! [reddift.Link]
                    self.source = children
                    print(self.source)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } catch { print(error) }
            
        }else {
            let alert = UIAlertController(title: "Inicia sesión para acceder a esta función", message: "Para poder acceder a las funciones de votar o guardar inicia sesión en la pestaña de usuario", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction) in
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.source.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let link: reddift.Link = self.source[indexPath.row]
        
        return (link.thumbnail.characters.count > 0) ? 297 :80;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SaveTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "savecell") as! SaveTableViewCell
        cell.delegate = self
        
        
        
        let link: reddift.Link = self.source[indexPath.row]
        cell.labelTitle.text = link.title
        cell.labelOP.text = "\(link.author) · \(tsToString(ts: link.created))· /r/\(link.subreddit)"
        
        cell.name = link.name
        
        if link.saved {
            cell.saveButton.imageView?.backgroundColor = UIColor.yellow
        }else {
            cell.saveButton.imageView?.backgroundColor = UIColor.white
        }
        
        
        
        let url = URL.init(string: link.thumbnail)
        cell.imageViewThumb.layer.cornerRadius = 3
        cell.imageViewThumb.image = #imageLiteral(resourceName: "placeholder")
        
        
        // Async management of the images
        if url != nil{
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if data != nil{
                        
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
        
        performSegue(withIdentifier: "webSegue2", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! Web2ViewController
        vc.url = self.urlActual
    }
    
    
    func reload() {
        DispatchQueue.main.async {
            self.setDataSource()
        }
    }

    

}
