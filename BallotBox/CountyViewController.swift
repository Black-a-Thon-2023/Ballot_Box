//
//  CountyViewController.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit

class CountyViewController: UIViewController {
    @IBOutlet weak var categoryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPress(_ sender: Any) {
        
        self.performSegue(withIdentifier: "passData", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passData" {
                       if let destVC = segue.destination as? PassViewController {
                           destVC.selectedCounty = categoryLabel.text ?? "Undefined"
                       }
                  }

    }
    
    
    @IBAction func halifax(){
        categoryLabel.text = "Halifax"
    }
    
    @IBAction func wake(){
        categoryLabel.text = "Wake"
    }
}
