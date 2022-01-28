//
//  AddSourceViewController.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 28.01.2022.
//

import UIKit

struct AddSourceKeysDefaults {
    static let keySourceName: String = "source name"
    static let keyUrlRss: String = "source name"
}


class AddSourceViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var sourceNameTextField: UITextField!
    @IBOutlet weak var urlRssTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addNewSourceButton(_ sender: Any) {
        if !sourceNameTextField.text!.isEmpty && !urlRssTextField.text!.isEmpty {
            if urlRssTextField.text?.range(of: #"(^https?:\/\/)"#, options: .regularExpression) != nil {
                RssSources.shared.saveSource(sourceName: sourceNameTextField.text!, urlRss: urlRssTextField.text!)
                self.navigationController?.popToRootViewController(animated: true)
            }

        }
    }
    
}

