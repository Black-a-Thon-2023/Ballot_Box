//
//  ToVoteViewController.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit
import AlamofireImage
import Parse

class ToVoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView2: UITableView!
    let cellReuseIdentifier = "cell2"
    var candidatesToVote = [PFObject]()

    @IBOutlet weak var safetyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView2.delegate = self
        tableView2.dataSource = self
        candidatesToVote = (self.tabBarController?.viewControllers![0] as! HomeViewController).toVote
        if (candidatesToVote.count > 0) {
            safetyLabel.isHidden = true
        } else {
            safetyLabel.isHidden = false
        }
        tableView2.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        candidatesToVote = (self.tabBarController?.viewControllers![0] as! HomeViewController).toVote
        if (candidatesToVote.count > 0) {
            safetyLabel.isHidden = true
        } else {
            safetyLabel.isHidden = false
        }
        tableView2.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidatesToVote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell:SmallCandidateTableViewCell = self.tableView2.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! SmallCandidateTableViewCell
            
        cell.candidateName.text = candidatesToVote[indexPath.row]["Name"] as? String
            
            let addToString = candidatesToVote[indexPath.row]["Party"] as? String
            cell.candidateParty.text = (addToString ?? "Undefined") + " Party"
            
                //cell.descriptionText.sizeToFit()
            /*
            cell.descriptionText.translatesAutoresizingMaskIntoConstraints = true
            cell.descriptionText.sizeToFit()*/
            //self.deleteButtonTapped(<#T##sender: UIButton##UIButton#>)
            cell.candidateXButton.addTarget(self, action: #selector(self.deleteButtonTapped(_:)), for: .touchUpInside) // Add the target to the button
            cell.candidateXButton.tag = indexPath.row

            
            let urlString = candidatesToVote[indexPath.row]["Picture"]
            let url = URL(string: urlString as! String)!
            
            cell.candidateImage.af.setImage(withURL: url)
            
            
            
            
                //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
                //cell.textLabel?.text = models[indexPath.row].title
                //cell.detailTextLabel?.text = models[indexPath.row].content
                //return cell
            
            
            return cell
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton){
         candidatesToVote.remove(at:sender.tag)
         tableView2.deleteRows(at:[IndexPath(row:sender.tag,section:0)],with:.none)
        

        tableView2.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
