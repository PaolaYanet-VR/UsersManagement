

import UIKit
import FirebaseFirestore

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var pickerData: [String] = ["Admin", "Normal"]
    var adminAux = false


    // IBOUTLET
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var pvUserType: UIPickerView!
    
    // IBACTIONS
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func onRegister(_ sender: Any) {
        if(txtName.text != "" && txtLastname.text != "" && txtEmail.text != "" && txtPassword.text != ""){
            addData(admin: adminAux, email: txtEmail.text!, lastname: txtLastname.text!, name: txtName.text!, password: txtPassword.text!)
            if(admin){
                performSegue(withIdentifier: "adminAddUser", sender: self)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            showAlert(title: "Empty fields", message: "Fill in the fields", sender: self, senderalt: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(admin){
            pvUserType.isHidden = false
            self.pvUserType.delegate = self
            self.pvUserType.dataSource = self
            
        }else{
            pvUserType.isHidden = true
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        if(pickerData[row] == "Admin") {
            adminAux = true
        }
        else
        {
            adminAux = false
        }
        
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Monserrat", size: 16)
        label.text = pickerData[row]
        label.textAlignment = .center
        return label
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
