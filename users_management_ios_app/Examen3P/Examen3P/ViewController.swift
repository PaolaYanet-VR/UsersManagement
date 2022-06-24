
import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    @Published var list = [UserModel]()
    var isAdmin = false
    var exists = false
    
    // IBOUTLETS
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    // IBACTIONS
    @IBAction func onLogin(_ sender: Any) {
        if(txtEmail.text != "" && txtPassword.text != ""){
            getData()
        }else{
            //ALERTA LLENA CAMPOS
            showAlert(title: "Empty fields", message: "Fill in the fields", sender: self, senderalt: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
                        
                        self.list.forEach { u in
                            if(self.txtEmail.text! == u.email && self.txtPassword.text! == u.password){
                                self.exists = true
                                self.isAdmin = u.admin
                                userActual = u
                            }
                        }
                        
                        if(self.exists){
                            if(self.isAdmin){
                                self.txtEmail.text = ""
                                self.txtPassword.text = ""
                                self.isAdmin = false
                                self.exists = false
                                self.performSegue(withIdentifier: "login", sender: self)
                            }else{
                                showAlert(title: "Oh no!", message: "U r not Admin, but welcome", sender: self, senderalt: nil)
                                
                            }
                        }else{
                            showAlert(title: "Wrong Credentials", message: "User does no exist", sender: self, senderalt: nil)
                        }
                    }
                }
            } else {
                
                // Hay un error
                print(error ?? "Error")
                
            }
            
        }
        
    }
    


}

