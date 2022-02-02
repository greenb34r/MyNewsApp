//
//  EditSourceViewController.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 28.01.2022.
//

import UIKit

class EditSourceViewController: UIViewController {


    
    @IBOutlet weak var editSourceNameTextField: UITextField! {
        didSet {
            editSourceNameTextField.text = AllSourcesViewController.broadcastSource
        }
    }
    
    
    @IBOutlet weak var editUrlRssTextField: UITextField! {
        didSet {
            editUrlRssTextField.text = AllSourcesViewController.broadcastUrl
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func editSourceButtom(_ sender: Any) {
        if editUrlRssTextField.text?.range(of: #"(^https?:\/\/)"#, options: .regularExpression) != nil {
            RssSources.shared.editSource(indexPath: AllSourcesViewController.indexPath!, sN: editSourceNameTextField.text!, uR: editUrlRssTextField.text!)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func deleteSourceButtom(_ sender: Any) {
        RssSources.shared.deleteSource(indexPath: AllSourcesViewController.indexPath!)
        self.navigationController?.popViewController(animated: true)
    }
    

}



