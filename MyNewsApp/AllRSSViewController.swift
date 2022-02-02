//
//  AllRSSViewController.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 31.01.2022.
//

import UIKit




class AllRSSViewController: UIViewController {
    var initAdd: () = ListItemsForRssHandler.shared.addToList()
    var allRssItems: [ListItemsForRss] = ListItemsForRssHandler.shared.getToList()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ListItemsForRssHandler.shared.addToList()
        allRssItems = ListItemsForRssHandler.shared.getToList()
        tableView.reloadData()
    }

}



extension AllRSSViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return allRssItems.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allRssItems[section].nameSource
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRssItems[section].listItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! RSSFeedTableViewCell
        cell.titleTextLabel.text = self.allRssItems[indexPath.section].listItems[indexPath.row].title
        cell.descriptionTextLabel.text = self.allRssItems[indexPath.section].listItems[indexPath.row].description
        cell.datePubTextLabel.text = self.allRssItems[indexPath.section].listItems[indexPath.row].pubDate
        return cell
    }
}
