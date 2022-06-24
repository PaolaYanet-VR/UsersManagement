
import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    
    @Published var list = [UserModel]()
    
    // GET DATA
    
    func getData(tabla : Bool, sender: UITableViewController?) {
        
        // Obtener referencia de la BD
        let db = Firestore.firestore()
        
        // Leer los documentos de una ruta especifica
        db.collection("users").getDocuments { snapshot, error in
            
            // Checar errores
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    // Actualizar las propiedades de la lista
                    //DispatchQueue.main.async {
                    
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
                        
                    //}
                }
                
                //self.tableView.reloadData()
                
            } else {
                
                // Hay un error
                print(error ?? "no pos no")
                
            }
            
        }
        
    }
    
    // DELETE
    
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
                    }

                }
            }
            
        }
    
    // ADD DATA
        
    func addData(admin: Bool, email: String, lastname: String, name: String, password: String) {
            
        // Get a reference to the database
        let db = Firestore.firestore()
            
        // Add a document to a collection
        db.collection("users").addDocument(data: ["admin": admin, "email": email, "lastname": lastname, "name": name, "password": password]) { error in
                
            // Check for errors
            if error == nil {
                // No errors
                    
                // Call get data to retrieve latest data
                //self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    
}
