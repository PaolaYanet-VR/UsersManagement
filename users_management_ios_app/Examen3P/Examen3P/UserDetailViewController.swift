

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtUserType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUsername.text = userSelected.name + " " + userSelected.lastname
        txtEmail.text = userSelected.email
        if userSelected.admin {
            txtUserType.text = "User Type: Admin"
        }
        else
        {
            txtUserType.text = "User Type: Normal"
        }
    }
    
    @IBAction func onback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
