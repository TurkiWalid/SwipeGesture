//
//  ViewController.swift
//  swipeGesture
//
//  Created by walid on 27/9/2021.
//  Copyright © 2021 walid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "cellTableViewCell", bundle: nil), forCellReuseIdentifier: "cellTableViewCell")
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animateFirstCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTableViewCell") as! cellTableViewCell
        cell.label.text = "cell no \(indexPath.row)"
        return cell
    }
    
    func animateFirstCell(){
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? cellTableViewCell else {
            return
        }
        cell.animateScrollViewToOffset(to: CGPoint(x: 50.0, y: 0.0),timing: .Short, completion: {
            cell.animateScrollViewToOffset(to: CGPoint(x:  0.0, y: 0.0),timing: .Short)
        })
    }
}

  
