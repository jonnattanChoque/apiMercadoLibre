//
//  ViewController.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchItems: UISearchBar!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableItems: UITableView!
    
    var items : [Item] = [Item]()
    private var cellItems = "cellItems"
    private var cellEmpty = "cellEmpty"
    private var cellDisconnected = "cellDisconnected"
    private var itemSelected : Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchItems.delegate = self
        self.tableItems.delegate = self
        self.tableItems.dataSource = self
        self.tableItems.isHidden = true
        
        
        tableItems.register(UINib(nibName: "cellItems", bundle: nil), forCellReuseIdentifier: cellItems)
        tableItems.register(UINib(nibName: "cellEmpty", bundle: nil), forCellReuseIdentifier: cellEmpty)
        tableItems.register(UINib(nibName: "cellDisconnected", bundle: nil), forCellReuseIdentifier: cellDisconnected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let destination = segue.destination as? DetailViewController{
                let row = (sender as! NSIndexPath).row;
                destination.item = items[row]
            }
        }
    }
    
    /// Function to show tableview and reload items
    func loadInfo(){
        self.items = itemModel.sharedInstance.dataSource()
        self.tableItems.reloadData()
        self.tableItems.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateLabel(title:String){
        self.titleLbl.text = title
    }
}

extension ViewController: ReloadViewDelegate{
    func reloadView() {
        self.titleLbl.backgroundColor = UIColor(named: "success")
        self.loadInfo()
    }
    
    func errorLoading(message: String) {
        self.titleLbl.backgroundColor = UIColor(named: "error")
        self.loadInfo()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let stext = searchBar.text{
            self.performSegue(withIdentifier: "loadingSegue", sender: nil)
            
            if !stext.isEmpty{
                itemModel.sharedInstance.delegate = self
                itemModel.sharedInstance.search(search: stext)
                self.updateLabel(title: stext)
            }
        }else{
            self.tableItems.reloadData()
        }
    }
    
    func addSearchDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissSearchKeyboard))
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissSearchKeyboard() {
        searchItems.endEditing(true)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0{
            return 1
        }else{
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if items.count > 1{
            return 150
        }else{
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data =  items
        
        if data.count > 0{
            let object = data[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellItems) as? cellItems
            
            cell?.display(object: object)
            return cell!
        }else{
            if Connection.isConnectedToNetwork(){
                let cell = tableView.dequeueReusableCell(withIdentifier:cellEmpty ) as? cellEmpty
                cell?.display()
                return cell!
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier:cellDisconnected ) as? cellDisconnected
                cell?.display()
                if let aCell = cell {
                    return aCell
                }
                return cell!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: indexPath);
    }
}

