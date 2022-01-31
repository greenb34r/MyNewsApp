//
//  AllRSSViewController.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 31.01.2022.
//

import UIKit




class AllRSSViewController: UIViewController {
    
    
    var allSources = RssSources.shared.getAllSources()
    var rssItems: [RSSItem]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()


    }
    
    func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://") {(rssItems) in
            self.rssItems = rssItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}



extension AllRSSViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allSources.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.allSources[section].sourceName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! RSSFeedTableViewCell
        cell.titleTextLabel.text = self.rssItems![indexPath.row].title
        cell.descriptionTextLabel.text = self.rssItems![indexPath.row].description
        cell.datePubTextLabel.text = self.rssItems![indexPath.row].pubDate
        return cell
    }
    
    
}
