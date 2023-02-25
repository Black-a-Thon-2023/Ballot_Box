//
//  QuizViewController.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var topics = ["Government Spending", "Job Creation", "Public Safety", "Healthcare", "Education", "Sustainability", "Affordable Housing", "Economic Development", "Women's Rights", "Community Support"]
    var cellReuseIdentifier = "cell3"
    var quizResults = [Float]()
    
    @IBOutlet weak var quizTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        quizTable.delegate = self
        quizTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:QuestionTableViewCell = self.quizTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! QuestionTableViewCell
        
        cell.topicLabel.text = topics[indexPath.row]
        
        
        return cell
    }
    
    @IBAction func onReset(_ sender: Any) {
        let cells = self.quizTable.visibleCells as! Array<QuestionTableViewCell>

            for cell in cells {
                cell.topicSlider.value = 50
                // look at data
            }
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let cells = self.quizTable.visibleCells as! Array<QuestionTableViewCell>

            for cell in cells {
                quizResults.append(cell.topicSlider.value)
            }
        //self.tabBarController?.
        (self.tabBarController?.viewControllers![0] as! HomeViewController).quizDataBack = quizResults
        
        //print((self.tabBarController?.viewControllers![0] as! HomeViewController).quizDataBack)
        //performSegue(withIdentifier: "quizDone", sender: self)
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizDone" {
                       if let destVC = segue.destination as? HomeViewController {
                           destVC.quizDataBack = quizResults
                       }
                  }

    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
