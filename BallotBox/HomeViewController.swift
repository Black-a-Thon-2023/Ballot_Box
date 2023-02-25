//
//  HomeViewController.swift
//  BallotBox
//
//  Created by Sharonda Daniels on 2/25/23.
//

import UIKit
import AlamofireImage
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    var candidates = [PFObject]()
    var fcandidates = [PFObject]()
    var toVote = [PFObject]()
    var quizDataBack = [Float]()


    @IBOutlet weak var countyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.tabBarController != nil) {
            let placeholder = (self.tabBarController as! PassViewController).selectedCounty
            countyLabel.text = placeholder + " County"
        }

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        //self.navi
        
        //print(self.tabBarController?.selectedIndex[0])
        

            
            let query = PFQuery(className: "Candidate")
            query.includeKeys(["Name", "Picture", "Party","Description","County","binaryIssues"])
            
            //query.limit = 20
            //print("hihihi")
            query.findObjectsInBackground{(candidates, error) in
                //print(candidates)
            if candidates != nil {
                self.fcandidates = candidates!
                
                // here here print(candidates![0]["Name"] ?? "")
                
                if self.quizDataBack.count != 0 {
                    //let sortedIndexes = self.sortedIndexes(of: self.quizDataBack)
                    var multipliedScores = [Float]()
                    var candidateScores = [Float()]
                    var i = 0
                    for _ in self.fcandidates{
                        let theArrayHere = (self.fcandidates[i]["binaryIssues"]) as! NSArray
                        //print(theArrayHere)

                        
                        let objCArray = NSMutableArray(array: theArrayHere)

                        //Convert one binary array of one candidate
                        if let swiftArray = objCArray as NSArray as? [Int] {

                            // Use swiftArray here
                            //print(swiftArray)
                            let a = 0
                            
                            // Get the multiplied scores for each answer
                            for _ in self.quizDataBack {
                                multipliedScores.append(self.quizDataBack[a] * Float(swiftArray[a]))
                            }
                            candidateScores.append(multipliedScores.reduce(0, +))
                            
                        }
                        
                        //self.candidates.append(self.fcandidates[sortedIndexes[i]])
                        i+=1
                    }
                    print (candidateScores)
                    
                    //var multipliedScores
                    
                    /*
                    for _ in self.fcandidates{
                        self.candidates.append(self.fcandidates[sortedIndexes[i]])
                    }
                     */
                    
                    
                } else {
                        var i = 0
                        
                        for obj in self.fcandidates{
                            if (self.fcandidates[i]["County"] as! String == (self.tabBarController as! PassViewController).selectedCounty){
                                self.candidates.append(obj)
                            } else {
                                //print(self.fcandidates[i]["County"] as! String)
                                //print((self.tabBarController as! PassViewController).selectedCounty)
                            }
                            i+=1;
                        }
                }
                
                self.tableView.reloadData()
                //print(candidates?.count)
                
                
                //self.tableView.estimatedRowHeight = 200

                //self.tableView.rowHeight = UITableView.automaticDimension

                }
            }
        
        
        
    }
    
    func sortedIndexes(of array: [Float]) -> [Int] {
        var indices = Array(array.indices)
        indices.sort { array[$0] > array[$1] || (array[$0] == array[$1] && $0 < $1) }
        return indices
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toVote = (self.tabBarController?.viewControllers![1] as! ToVoteViewController).candidatesToVote
        
        if self.quizDataBack.count != 0 {
            //let sortedIndexes = self.sortedIndexes(of: self.quizDataBack)
            var multipliedScores = [Float]()
            var candidateScores = [Float]()
            var i = 0
            
            
            for _ in self.candidates{
                //print("Candidate scores " + String(candidateScores.count) + " members")
                //print("Candidates has " + String(self.candidates.count) + " members")
                var theArrayHere = (self.candidates[i]["binaryIssues"]) as! NSArray
                //print(theArrayHere)

                
                var objCArray = NSMutableArray(array: theArrayHere)

                //Convert one binary array of one candidate
                if let swiftArray = objCArray as NSArray as? [Int] {

                    // Use swiftArray here
                    //print(swiftArray)
                    var a = 0
                    
                    // Get the multiplied scores for each answer
                    for _ in self.candidates {
                        multipliedScores.append(self.quizDataBack[a] * Float(swiftArray[a]))
                        a+=1
                    }
                    //print("Candidate scores " + String(candidateScores.count) + " members")
                    candidateScores.append(multipliedScores.reduce(0, +))
                    //print("Candidate scores " + String(candidateScores.count) + " members")

                    multipliedScores = []
                    
                }
                //print("Candidate scores " + String(candidateScores.count) + " members")
                
                //self.candidates.append(self.fcandidates[sortedIndexes[i]])
                i+=1
            }
            //print (candidateScores)
            
            //var multipliedScores
            var timesToIterate = candidates.count
            var duplicateCandidates = candidates
            candidates = []
            //eh print(candidateScores)
            let sortedIndexes = self.sortedIndexes(of: candidateScores)
            //eh print(sortedIndexes)
            //candidateScores.remove(at: 0)
            var z = 0
            for _ in candidateScores{
                //print("hi")
                self.candidates.append(duplicateCandidates[sortedIndexes[z]])
                z+=1
            }
            
            tableView.reloadData()
             
            
            
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return candidates.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LargeCandidateTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LargeCandidateTableViewCell
        
        cell.name.text = candidates[indexPath.row]["Name"] as? String
        
        let addToString = candidates[indexPath.row]["Party"] as? String
        cell.party.text = (addToString ?? "Undefined") + " Party"
        
        cell.descriptionText.text = candidates[indexPath.row]["Description"] as? String
            //cell.descriptionText.sizeToFit()
        /*
        cell.descriptionText.translatesAutoresizingMaskIntoConstraints = true
        cell.descriptionText.sizeToFit()*/
        //self.deleteButtonTapped(<#T##sender: UIButton##UIButton#>)
        cell.deleteBTN.addTarget(self, action: #selector(self.deleteButtonTapped(_:)), for: .touchUpInside) // Add the target to the button
        cell.deleteBTN.tag = indexPath.row

        
        let urlString = candidates[indexPath.row]["Picture"]
        let url = URL(string: urlString as! String)!
        
        cell.candidateImage.af.setImage(withURL: url)
        
        
        
        
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            //cell.textLabel?.text = models[indexPath.row].title
            //cell.detailTextLabel?.text = models[indexPath.row].content
            //return cell
        
        
        return cell
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton){
        toVote.append(candidates[sender.tag])
         candidates.remove(at:sender.tag)
         tableView.deleteRows(at:[IndexPath(row:sender.tag,section:0)],with:.none)
        tableView.reloadData()
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
