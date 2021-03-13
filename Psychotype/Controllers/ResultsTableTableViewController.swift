//
//  ResultsTableTableViewController.swift
//  Psychotype
//
//  Created by mac on 19.01.2021.
//

import UIKit

class ResultsTableTableViewController: UITableViewController {
    
    var results = [Result]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        results  = CoreDataManager.shared.fetchResult().reversed()
 
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     title = "Результаты"
        
    }
  
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results.isEmpty {
            return 1
        }
        return results.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResultsTableViewCell

        if results.isEmpty{
            cell.setupEmptyCell()
            tableView.allowsSelection = false
            
        } else {
            cell.setupResult(with: results[indexPath.row])
            tableView.allowsSelection = true
        }
  
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        performSegue(withIdentifier: "showExpanded", sender: index)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExpanded", let index = sender as? Int {
            let resultVC = segue.destination as! ExpandedResultViewController
            resultVC.result = results[index]
    }
  }

}
