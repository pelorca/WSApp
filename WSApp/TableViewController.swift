//
//  TableViewController.swift
//  WSApp
//
//  Created by Pelorca on 06/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    @IBOutlet weak var btnSearch: UIBarButtonItem!
    
  
    @IBOutlet weak var navItem: UINavigationItem!

    
    var itemSelected: TaskEntity?
    
    var listTask: Results<TaskEntity>?

    
  
    var task: Task?
    var searchController: UISearchController!
    
    @IBAction func btnSearch(_ sender: UIBarButtonItem) {
        self.searchController = searchControllerWith(searchResultsController: nil)
        self.navItem.titleView = self.searchController.searchBar
        self.definesPresentationContext = true
        self.btnSearch.tintColor = UIColor.clear
        self.btnSearch.isEnabled = false
     }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.resignFirstResponder()
        self.btnSearch.tintColor = UIColor.white
        self.btnSearch.isEnabled = true
         self.navItem.titleView = nil
    }
    
    func cancelBarButtonItemClicked() {
        self.searchBarCancelButtonClicked(self.searchController.searchBar)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTaskBD()
        self.tableView.reloadData()
       
    }
    
    func searchControllerWith(searchResultsController: UIViewController?) -> UISearchController {
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.barTintColor = UIColor.white
        
        return searchController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getTaskBD()
        self.tableView.reloadData()
        
    }
    
    func getTaskBD() {
        listTask =  Repository().selectTaskNotRemoved()
    }
    
    func delete(_ tableView: UITableView, id: String, indexPath: IndexPath) {
        
        TaskService().delete(id: id, onSuccess: { response in
       }, onError: { _ in
           print("Falha ao realizar exlcusao de tasks ")
        }, always: {
           
        })
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemSelected = self.listTask?[indexPath.row]
        self.performSegue(withIdentifier: "editTask",  sender: self.itemSelected)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

 

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (listTask?.count ?? 0)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return CGFloat(130)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        guard listTask?.count == 0 else  {
            cell.imgOval.isHidden = (listTask![indexPath.row].isComplete)
            cell.lblTitulo.text = (listTask![indexPath.row].title)!
            cell.lblDetails.text = (listTask![indexPath.row].descriptionTask)!
            cell.lblHora.text = (listTask![indexPath.row].expirationDate)?.split(separator: "-")[2].description
         return cell
        }
      return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = listTask![indexPath.row].serverId {
                 delete(tableView, id: id, indexPath: indexPath)
            }
            let item = TaskEntity().toEntity(item: listTask![indexPath.row])
            item.removed = true
            Repository().update(data: item)
            getTaskBD()
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
      }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            listTask = Repository().selectTaskNotRemoved()
     } else {
            listTask = Repository().selectTask(searchText)
        }
        self.tableView.reloadData()
    }
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
        navigationItem.titleView?.tintColor = UIColor.white
        
        
        if segue.identifier == "editTask"{
            let page: AddTaskViewController = segue.destination as! AddTaskViewController
            
            let item = sender as! TaskEntity
            page._editable = true
            page._isCompleto = item.isComplete
            page._titulo = item.title
            page._descricao = item.descriptionTask
            page._dataExpericao = item.expirationDate?.convertToDate()
            page.id = item.serverId
        }
        
    }

  

 

}

extension String {
    func convertToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if self != nil {
            return formatter.date(from: self)!
        } else  {
            return Date()
        }
        
    }
    
}


extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if self != nil {
            return formatter.string(from: self)
        } else  {
            return ""
        }
        
    }
    
}
