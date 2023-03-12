//
//  ViewController.swift
//  ToDoApp
//
//  Created by Oktay Resulzade on 10.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var task = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        
        updateTasks()
        
    }
    
    
    func updateTasks() {
        
        task.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count {
            
            if let tasks = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                task.append(tasks)
                
            }
            
        }
        tableView.reloadData()
    }
    
    
    @IBAction func didTapAdd () {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
           
            
        }
        navigationController?.pushViewController(vc, animated: true)
        
            
        
        
        
    }
    
    
    
 
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
           
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = task[indexPath.row]
        
        return cell
    }
    
    
    
}
