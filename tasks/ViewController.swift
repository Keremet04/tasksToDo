//
//  ViewController.swift
//  tasks
//
//  Created by Керемет  on 16/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    
    
    private let table :  UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    var items: [String] = ["Get milk", "wash dishes", "throw the trash", "do the homework", "go to gym", "read teh book"]
    
    
    var filteredTasks: [String] = []
    
    
    var addButton = UIButton(type: .system)
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "TO DO LIST"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New item ", message: "Enter new to do list item", preferredStyle: .alert)
        
        alert.addTextField{ field in field.placeholder = "Enter item..."}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
           
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    
                    DispatchQueue.main.async {
                        self?.items.append(text)
                        self?.table.reloadData()
                        
                    }
                    
                }
            }
        }))
        
        present(alert, animated: true)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds 
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int  ) -> Int{
        
        return items.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt  indexPath: IndexPath) -> UITableViewCell{
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
       
        
        return cell
        
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

