
import UIKit
import FirebaseFirestore


class UsersTableViewController: UITableViewController {
    
    let pullToRefreshControl = UIRefreshControl()
    
    @Published var list = [UserModel]()
    
    @IBAction func onAdd(_ sender: Any) {
        admin = true
        performSegue(withIdentifier: "addUser", sender: self)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        admin = false
        userActual = UserModel(id: "", admin:  false, email:  "", lastname:  "", name:  "", password:  "")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Obtenemos los datos
        getData()
        self.title = "Welcome " + userActual.name + "!"
        //control refresh
        self.refreshControl = pullToRefreshControl
        
        pullToRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
    }
    
    @objc func refreshTable() {
        getData()
        self.tableView.reloadData()
        pullToRefreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    //MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].name + " " + list[indexPath.row].lastname
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(userToDelete: list[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //MARK: Seleccionar usuario
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userSelected = list[indexPath.row]
    }
    
    
    // GET DATA
    
    func getData() {
        // Obtener referencia de la BD
        let db = Firestore.firestore()
        
        // Leer los documentos de una ruta especifica
        db.collection("users").getDocuments { snapshot, error in
            
            // Checar errores
            if error == nil {
                
                if let snapshot = snapshot {
                    // Actualizar las propiedades de la lista
                    DispatchQueue.main.async {
                    
                        // Obtenemos todos los docs y agregamos a la lista
                        self.list = snapshot.documents.map { d in
                            
                            // Crea al usuario para cada doc
                            return UserModel(id: d.documentID,
                                             admin: d["admin"] as? Bool ?? false,
                                             email: d["email"] as? String ?? "",
                                             lastname: d["lastname"] as? String ?? "",
                                             name: d["name"] as? String ?? "",
                                             password: d["password"] as? String ?? "")
                        }
                        
                        self.tableView.reloadData()
                    }
                }
            }
            else
            {
                //self.showAlert(ttl: "Error", msg: "Error")
                // Hay un error
                print(error ?? "no pos no")
            }
        }
    }
    
    // DELETE DATA
    
    func deleteData(userToDelete: UserModel) {
            
            // Get a reference to the database
            let db = Firestore.firestore()
            
            // Specify the document to delete
            db.collection("users").document(userToDelete.id).delete { error in
                
                // Check for errors
                if error == nil {
                    // No errors
                    
                    // Update the UI from the main thread
                    DispatchQueue.main.async {
                        
                        // Remove the todo that was just deleted
                        self.list.removeAll { userModel in
                            
                            // Check for the todo to remove
                            return userModel.id == userToDelete.id
                        }
                        
                        //self.showAlert(ttl: "Deleted User", msg: "")
                        
                        self.tableView.reloadData()
                    }

                }
            }
    }
    
    func showAlert(ttl: String, msg: String) {
        
        let alert = UIAlertController(title: ttl, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: {
            _ in
            //
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
