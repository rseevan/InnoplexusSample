//
//  ContactDescriptionViewController.swift
//  InnoplexusSample
//
//  Created by Seevan Ranka on 03/01/18.
//  Copyright © 2018 Seevan Ranka. All rights reserved.
//

import UIKit

class ContactDescriptionViewController: UIViewController {
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var mobileView: UIView!
    
    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var streetLbl: UILabel!
    
    @IBOutlet weak var suiteLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var zipcodeLbl: UILabel!
    
    @IBOutlet weak var latitudeLbl: UILabel!
    
    @IBOutlet weak var longLbl: UILabel!
    
    
    @IBOutlet weak var comapnayView: UIView!
    
    @IBOutlet weak var cname: UILabel!
    
    @IBOutlet weak var catchPhrase: UILabel!
    
    @IBOutlet weak var bsLbl: UILabel!
    
    var contactDetails: ContactModel!
    
    @IBOutlet weak var websiteBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(BackAction(sender:)))
        navigationItem.title = contactDetails?.name
        setUpUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func BackAction(sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpUI()
    {
        userNameLbl.text = contactDetails.username
        mobileLbl.text = contactDetails.phone
        emailLbl.text = contactDetails.email
        streetLbl.text = contactDetails.address.street
        suiteLbl.text = contactDetails.address.suite
        cityLbl.text = contactDetails.address.city
        zipcodeLbl.text = contactDetails.address.zipcode
        latitudeLbl.text = contactDetails.address.geo.lat.description
        longLbl.text = contactDetails.address.geo.lng.description
        cname.text = contactDetails.company.name
        catchPhrase.text = contactDetails.company.catchPhrase
        bsLbl.text = contactDetails.company.bs
        websiteBtnOutlet.setTitle(contactDetails.website, for: .normal)
        let color2 = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        addressView.layer.borderColor = color2
        addressView.layer.borderWidth = 0.5
        addressView.layer.cornerRadius = 5
        
        comapnayView.layer.borderColor = color2
        comapnayView.layer.borderWidth = 0.5
        comapnayView.layer.cornerRadius = 5

    }
    @IBAction func wesiteLinkPressed(_ sender: Any) {
        guard let url = URL(string: contactDetails.website) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
