//
//  AllSourcesViewController.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 28.01.2022.
//

import UIKit

class AllSourcesViewController: UIViewController {
    
    static var broadcastSource: String?
    static var broadcastUrl: String?
    static var indexPath: Int?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
   
}


extension AllSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RssSources.shared.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let dCell = tableView.dequeueReusableCell(withIdentifier: "dCell") {
            cell = dCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "dCell")
        }
        cell.textLabel?.text = "\(RssSources.shared.sources[indexPath.row].sourceName)"
        cell.detailTextLabel?.text = "\(RssSources.shared.sources[indexPath.row].urlRss)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //AdresessViewController.templateText = indexPath.row as? Int
        performSegue(withIdentifier: "editSources", sender: Any?.self)
        AllSourcesViewController.broadcastSource = "\(RssSources.shared.sources[indexPath.row].sourceName)"
        AllSourcesViewController.broadcastUrl = "\(RssSources.shared.sources[indexPath.row].urlRss)"
        AllSourcesViewController.indexPath = indexPath.row
    }

}
