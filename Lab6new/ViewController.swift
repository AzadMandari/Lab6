import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listOfItem: [String] = []
    
    let userDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var TableListView: UITableView!
    
    
    @IBAction func AddButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add An Item", message: nil, preferredStyle: .alert)
           
           alert.addTextField { (textField) in
               textField.placeholder = "Enter an Item"
           }
           
           alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
               alert?.dismiss(animated: true)
           }))
           
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
               let textField = alert?.textFields![0]
               if let newItem = textField?.text, !newItem.isEmpty {
                   self.listOfItem.append(newItem)
                   self.saveItems()
                   self.TableListView.reloadData()
               }
           }))
           
           self.present(alert, animated: true, completion: nil)
    }
   
        override func viewDidLoad() {
        super.viewDidLoad()
        TableListView.dataSource = self
        TableListView.delegate = self
        getItemsFromStorage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItem.count
    }
    
    
    //To Display All Items in Table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = listOfItem[indexPath.row]
        return cell
    }
    
    
    //To Delete an Item from List
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedItemIndex = indexPath.row
            listOfItem.remove(at: deletedItemIndex)
            saveItems()
            
            let indexPathToDelete = IndexPath(row: deletedItemIndex, section: 0)
            TableListView.deleteRows(at: [indexPathToDelete], with: .automatic)
        }
    }

    //delete button at left
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }

    //Save the Item to Local storage
    func saveItems() {
         userDefaults.set(listOfItem, forKey: "ItemsSaved")
     }
    
    
    func getItemsFromStorage() {
         if let savedItems = userDefaults.array(forKey: "ItemsSaved") as? [String] {
             listOfItem = savedItems
         } else {
             listOfItem = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8","Item 9","Item 10"]
         }
     }
}
