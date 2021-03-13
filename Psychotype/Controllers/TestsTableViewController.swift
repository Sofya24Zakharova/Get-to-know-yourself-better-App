//
//  TestsTableViewController.swift
//  Psychotype
//
//  Created by mac on 20.01.2021.
//

import UIKit

class TestsTableViewController: UITableViewController {
    
    private var alertView : CustomAlertController!
    
    private let transparentView = UIView()
    
    private var tests = Test.getTests()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView = Bundle.main.loadNibNamed("CustomAlertController", owner: nil, options: nil)?.first as? CustomAlertController
        
        setupHeader()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue){
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! TestsTableViewCell
        
        let testName = tests[indexPath.row].nameOfTest
        
        cell.setupCell(with: testName)
        
        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testName = tests[indexPath.row].nameOfTest
        
        if CoreDataManager.shared.checkResult(with: testName){
            showAlert(indexPath.row)
        } else {
        let index = indexPath.row
        performSegue(withIdentifier: "goToDescription", sender: index)
    }
        tableView.deselectRow(at: indexPath, animated: true)
 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDescription", let index = sender as? Int {
            let descriptionVC = segue.destination as! DescriptionViewController
            descriptionVC.test = tests[index]
    }
   }
    
   private func setupHeader() {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
    header.backgroundColor = UIColor.clear
    
    let label = UILabel(frame: CGRect(x: 20, y: 15 , width: view.frame.size.width - 40, height: 80))      //UILabel(frame: header.bounds)
        label.text = "Тесты, которые помогут лучше себя узнать:"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        //label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        header.addSubview(label)
        tableView.tableHeaderView = header
        
    }
    
    private func showAlert(_ index: Int) {
        transparentView.backgroundColor = UIColor.black
        transparentView.frame = self.view.frame
        transparentView.alpha = 0
        view.addSubview(transparentView)
        
        alertView.delegate = self
        alertView.indexOfTest = index
        
        view.addSubview(alertView)
        
//        self.alertView.frame = CGRect(x: self.view.frame.minX + 20, y: self.view.frame.midY - 170, width: self.view.frame.width - 40, height: 250)
        
        alertView.center = view.center
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.alpha = 1
            self.transparentView.alpha = 0.7
        })
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       if scrollView.contentOffset.y > 20 {
        UIView.animate(withDuration: 1) {
            self.tableView.tableHeaderView?.isHidden = true
        }
        
        } else if scrollView.contentOffset.y < 20 {
            self.tableView.tableHeaderView?.isHidden = false
            
        }
            
    }
}
   
extension TestsTableViewController : CustomAlertControllerDelegate{
    func didTappedYes(with index: Int) {
        performSegue(withIdentifier: "goToDescription", sender: index)
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.alpha = 0
            self.transparentView.alpha = 0
            
        })
    }
    
    func didTappedNo() {
        UIView.animate(withDuration: 0.3, animations: {
                        self.alertView.alpha = 0
                        self.transparentView.alpha = 0
            
        })
    }
    
    
}
