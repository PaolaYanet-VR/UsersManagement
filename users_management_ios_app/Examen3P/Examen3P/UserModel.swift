
import Foundation
import UIKit

var listUserAux = [UserModel]()

var userSelected = UserModel(id: "", admin:  false, email:  "", lastname:  "", name:  "", password:  "")
var userActual = UserModel(id: "", admin:  false, email:  "", lastname:  "", name:  "", password:  "")

var admin = false

struct UserModel: Identifiable {
    
    var id: String
    var admin: Bool
    var email: String
    var lastname: String
    var name: String
    var password: String
    
}

func showAlert(title: String, message:String, sender:UIViewController?, senderalt:UITableViewController?){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let ok = UIAlertAction(title: "OK", style: .default){
        (UIAlertAction) in
    }
    
    alert.addAction(ok)
    
    if(sender != nil){
        sender!.present(alert, animated: true, completion: nil)
    }else if(senderalt != nil){
        senderalt!.present(alert, animated: true, completion: nil)
    }
}
