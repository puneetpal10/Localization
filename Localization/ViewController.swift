//
//  ViewController.swift
//  Localization
//
//  Created by PuNeet on 01/12/19.
//  Copyright © 2019 Puneet. All rights reserved.
//

import UIKit
struct Constant {
//MARK:- Screen Width/Height MACRO
static let userDefaults = UserDefaults.standard
}
class ViewController: UIViewController {

    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var btnFirst: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblFirst.text = "Surname".getLOCText()
    }

    @IBAction func segTapped(_ sender: UISegmentedControl ) {
        
        if(sender.selectedSegmentIndex == 0){
            languageChange(strLan: "en")
            ParameterName.english.storeForKey(ParameterName.language)
                       languagePrefrences = ParameterName.english
            lblFirst.text = "Surname".getLOCText()

        }else{
            ParameterName.spnanish.storeForKey(ParameterName.language)
                       languagePrefrences = ParameterName.spnanish
//
//            UserDefaults.standard.set(["es"], forKey: "AppleLanguages")
//                      UserDefaults.standard.synchronize()
//            languageChange(strLan: "es")
            lblFirst.text = "Surname".getLOCText()

        }
    }
    
    func languageChange(strLan: String){
        lblFirst.text = "Surname".getLOCText()
        lblSecond.text = "lastName".localizableString(loc: strLan)
        

    }
    
}

extension String{
    func localizableString(loc: String) ->String{
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func storeForKey(_ keyString : String) {
        Constant.userDefaults.set(self, forKey: keyString)
        Constant.userDefaults.synchronize()
    }
    
    func getValueForKey() -> String? {
        return Constant.userDefaults.value(forKey: self) as? String
    }
}

