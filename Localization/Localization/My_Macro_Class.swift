//
//  My_Macro_Class.swift
//  Medusa
//
//  Created by Vikas Upadhyay on 04/01/18.
//

import UIKit

// Device info



let BOT_TAB_HEIGHT : CGFloat = 50

enum STORYBOARD_NAME : String {
    case main = "Main"
//    case restaurantiPad = "RestaurantiPad"
//    case restaurantiPhone = "RestaurantiPhone"
//    case dreamsAPI = "DreamsAPI"
//    case barAndKichen = "BarAndKichen"
    

}

let UltraLtdMainStoryboard = UIStoryboard(name: STORYBOARD_NAME.main.rawValue, bundle: nil)

var dictLocalisation : NSDictionary!

//Basic Function
func getLOCText(_ key :String)-> String {
    if (UIApplication.shared.keyWindow != nil) {
        if let path = Bundle.main.url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: languagePrefrences)?.path {
            if FileManager.default.fileExists(atPath: path)     {
                dictLocalisation = NSDictionary(contentsOfFile: path)
                //            print(dictLocalisation)
                return localizedStringForKey(key: key)
            }
        }
    }
    return key
}

extension String {
    func getLOCText()-> String {
        if (UIApplication.shared.keyWindow != nil) {
            if let path = Bundle.main.url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: languagePrefrences)?.path {
                if FileManager.default.fileExists(atPath: path)     {
                    dictLocalisation = NSDictionary(contentsOfFile: path)
                    //            print(dictLocalisation)
                    return localizedStringForKey(key: self)
                }
            }
        }
        return self
    }
}

func localizedStringForKey(key:String) -> String {
    LocalizationManageModel.sharedInstance.keyAdd(key)
    if let dico = dictLocalisation {
        if let localizedString = dico[key] as? String {
            return localizedString
        }  else {
            return key
        }
    } else {
        return NSLocalizedString(key, comment: key)
    }
}

// MARK:- String to Dictionary
func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func convertToArray(text: String) -> [AnyObject]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}



