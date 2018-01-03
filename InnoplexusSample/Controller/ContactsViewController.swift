//
//  ContactsViewController.swift
//  InnoplexusSample
//
//  Created by Seevan Ranka on 03/01/18.
//  Copyright © 2018 Seevan Ranka. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON
import Toast_Swift

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contactsTableView: UITableView!
    var contactsArray: [ContactModel]?
    @IBOutlet weak var loadingLbl: UILabel!
    let tron = TRON(baseURL: "http://jsonplaceholder.typicode.com/")
    var isAsc = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.tableFooterView = UIView()
        ToastManager.shared.style = ToastStyle()
        self.view.makeToastActivity(.center)
        //self.view.makeToast("Loading Contacts...", duration: 0.0, position: .center, title: "", image: nil, style: ToastStyle(), completion: nil)
        getContacts()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // fetch data
    
    @IBAction func sortingBtnPressed(_ sender: Any) {
        if isAsc{
            contactsArray = contactsArray?.sorted(by: { $0.name >  $1.name })
            navigationItem.rightBarButtonItem?.title = "A-Z"
            isAsc = false
        } else {
            contactsArray = contactsArray?.sorted(by: { $0.name <  $1.name })
            navigationItem.rightBarButtonItem?.title = "Z-A"
            isAsc = true
        }
        contactsTableView.reloadData()
    }
    func getContacts()
    {
        let request: APIRequest<Contact,JSONError> = tron.swiftyJSON.request("users")
        request.perform(withSuccess: { user in
            print("Received user")
            self.contactsArray = user.contactsArray
            self.contactsArray = self.contactsArray?.sorted(by: { $0.name <  $1.name })
            self.view.hideToastActivity()
            self.loadingLbl.isHidden = true
            self.contactsTableView.reloadData()
            print(user.contactsArray.count)
        }) { (err) in
            self.view.hideToastActivity()
            self.loadingLbl.isHidden = true
            print("error", err)
        }
    }
    //MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let carray = contactsArray {
            return carray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // #warning Incomplete implementation, return the number of rows
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        
        let contact = contactsArray![indexPath.section]
        let color2 = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        cell.contentView.layer.borderColor = color2
        cell.contentView.layer.borderWidth = 0.5
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.shadowColor = UIColor.gray.cgColor
        cell.contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.contentView.layer.shadowRadius = 5;
        cell.contentView.layer.shadowOpacity = 0.25;
        cell.nameLbl.text = contact.name
        cell.phoneLbl.text = contact.phone
        //        let shadowFrame = cell.contentView.layer.bounds;
        //        let shadowPath = UIBezierPath.init(roundedRect: shadowFrame, cornerRadius: 5)
        //        cell.contentView.layer.shadowPath = shadowPath.cgPath
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle .main).instantiateViewController(withIdentifier: "ContactDescriptionViewController") as! ContactDescriptionViewController
        vc.contactDetails = contactsArray![indexPath.section]
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }

}

class Contact: JSONDecodable {
    let contactsArray : [ContactModel]
    required init(json: JSON) throws{
        let array1 = json.array
        var contactsArray = [ContactModel]()
        for user in array1! {
            let id = user["id"].int64Value
            let name = user["name"].stringValue
            let username = user["username"].stringValue
            let email = user["email"].stringValue
            let street = user["address"]["street"].stringValue
            let suite = user["address"]["suite"].stringValue
            let zipcode = user["address"]["zipcode"].stringValue
            let lat = user["geo"]["lat"].doubleValue
            let lng = user["geo"]["lng"].doubleValue
            let phone = user["phone"].stringValue
            let website = user["website"].stringValue
            let cname = user["company"]["name"].stringValue
            let catchPhrase = user["company"]["catchPhrase"].stringValue
            let bs = user["company"]["bs"].stringValue
            let contactMdl = ContactModel(id: id, name: name, username: username, email: email, street: street, suite: suite, city: user["address"]["city"].string!, zipcode: zipcode, lat: lat, lng: lng, phone: phone, website: website, cname: cname, catchPhrase: catchPhrase, bs: bs)
            contactsArray.append(contactMdl)
        }
        self.contactsArray = contactsArray
    }
}

class JSONError: JSONDecodable {
    required init(json: JSON) throws {
        print("JSON Error")
    }
}

