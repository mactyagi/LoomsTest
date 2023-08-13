//
//  ViewController.swift
//  LoomsTest
//
//  Created by Manu on 12/08/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        let data = ideas[indexPath.row]
        if let name = data.linkIdea?.name{
            cell.ideaButton.isHidden = false
            cell.ideaButton.setTitle("<\(name)>", for: .normal)
        }else{
            cell.ideaButton.isHidden = true
        }
        cell.ideaLabel.text = data.name
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    var ideas = [Idea](){
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        addData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func plusButtonPressed(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddDetailViewController") as! AddDetailViewController
        vc.ideas = ideas
        vc.dismissed = { ideas in
            self.ideas = ideas
        }
        self.present(vc, animated: true)
    }
    
    func addData(){
        var data = [Idea(name: "My Idea 1")]
        data.append(Idea(name: "My Idea 2"))
        data.append(Idea(name: "My Idea 3"))
        ideas += data
    }
}

class Idea{
    var name:String
    weak var linkIdea: Idea?
    init(name: String, linkIdea: Idea? = nil) {
        self.name = name
        self.linkIdea = linkIdea
    }
}

