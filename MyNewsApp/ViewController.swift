//
//  ViewController.swift
//  MyNewsApp
//
//  Created by Greenb34r on 24.01.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    let idCell = "New Cell"
    var allArticles: [NewsListItem]?
    var totalResults: Int?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsFeedView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        newsFeedView.dataSource = self
        newsFeedView.delegate = self
    }


}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.newsFeedView.reloadData()
        searchBar.resignFirstResponder()
        let encodedString  = "\(searchBar.text!)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString = "https://newsapi.org/v2/everything?q=\(encodedString!)&apiKey=d8316c9171354bd49341f3b214f52086"
        let url = URL(string: urlString)
        print(urlString)
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print("ERROR ")
            }
            if data != nil {
                let parsedJson = parseFromData(data: data!)
                self.allArticles = parsedJson.articles
                self.totalResults = parsedJson.totalResults
                DispatchQueue.main.async {
                    self.newsFeedView.reloadData()
                }
                }
        }
        task.resume()
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // newsFeedView.sectionHeaderHeight = 50.0
        return "TOTAL RESULTS: \(totalResults ?? 0)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 90, y: 0, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 22)
        myLabel.textColor = .black
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        let headerView = UIView()
        headerView.addSubview(myLabel)
        headerView.backgroundColor = .white


        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allArticles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: idCell)
            print("create")
        }
        if (self.allArticles?.count != 0) {
            let newsIndex = self.allArticles?[indexPath.row]
            print(indexPath.row)
            DispatchQueue.main.async {
                cell!.textLabel?.text = newsIndex?.title
                cell!.detailTextLabel?.text = newsIndex?.description
            }
        } else {
            DispatchQueue.main.async {
                cell!.textLabel?.text = " "
                cell!.detailTextLabel?.text = " "
            }
        }
        return cell! 
        }
    
    }
