

import UIKit

class ViewController: UIViewController {
    
    
    var itemsArray = [String]()
    var numberTasks = [Int]()
    
    private var openMenu = true
    private var hidenTrash = true
    
    var textTF = String()
    
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var tfWriteTask: UITextField!
    @IBOutlet weak var addTask: UIButton!
    @IBOutlet weak var viewAddTask: UIView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        viewAddTask.isHidden = openMenu
        trashButton.isHidden = hidenTrash
        
        if let data=UserDefaults.standard.object(forKey: "todolist") as? [String]{
            itemsArray=data
        }
        
        if let data=UserDefaults.standard.object(forKey: "time") as? [Int]{
            numberTasks=data
        }
        
        
     
        
        
        
    }
    
    // нажатие на карандашик
    @IBAction func openMenuWriteTasks(_ sender: Any) {
        openMenu.toggle()
        viewAddTask.isHidden = openMenu
        tfWriteTask.text = ""

        
    }
    
    
    @IBAction func addTask(_ sender: Any) { // кнопка которую нажимаем при отправке задачи
        
        var uniq = Array(Set(numberTasks))
        uniq.sort()
        uniq.removeFirst()
        
        
        openMenu.toggle()
        guard tfWriteTask.text != "" else {
            openMenu.toggle()
            viewAddTask.isHidden = openMenu
            print("errir")
            return}
        hidenTrash.toggle()
        viewAddTask.isHidden = openMenu
        trashButton.isHidden = hidenTrash
        
        itemsArray.append(tfWriteTask.text!)
        UserDefaults.standard.setValue(itemsArray, forKey: "todolist")
        myTableView.reloadData()
        
        openMenu.toggle()
        
    }
    @IBAction func deletedAllElements(_ sender: Any) {
        UserDefaults.standard.setValue(itemsArray, forKey: "todolist")
        itemsArray.removeAll()
        myTableView.reloadData()
        trashButton.isHidden = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
        var uniq = Array(Set(numberTasks))
        uniq.sort()
        uniq.removeFirst()
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewCell
        cell.task?.text = " \(itemsArray[indexPath.row])"
        cell.numberTasks?.text = "\(uniq[indexPath.row])"
//        cell.numberTasks.text="\(numberTasks[indexPath.row])"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            itemsArray.remove(at: indexPath.row)
            UserDefaults.standard.synchronize()
            myTableView.reloadData()
            UserDefaults.standard.setValue(itemsArray, forKey: "todolist")
            UserDefaults.standard.synchronize()
        }
    }
}






