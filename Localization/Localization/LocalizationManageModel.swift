//
//  LocalizationManagerModel.swift
//  Medusa
//
//  Created by Vikas Upadhyay on 09/01/18.
//

import UIKit
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
var languagePrefrences = "en"
struct ParameterName {
    static let language          = "language"
    static let english           = "en"
    static let spnanish          = "es"
  
    


    
    
    static func getCurrentLanguage() -> String {
        switch ParameterName.language.getValueForKey() {
        case "es":
            return "spanish"

        default:
            return "english"
        }
    }
    
}
class LocalizationManageModel: NSObject {
//    var colorPicker : ColorPickerViewController?
    var keyDict  : [String] = []
    
    static let sharedInstance : LocalizationManageModel = {
        let instance = LocalizationManageModel()
        instance.loadOldFile()
        
        if ParameterName.language.getValueForKey() == ParameterName.spnanish {
            languagePrefrences = ParameterName.spnanish
        }
        return instance
            
    }()
    
    func loadOldFile() {
        let file = "Localizable.strings"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            print("Localizable.strings : ")
            print(path)
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
                let oldArray = text2.components(separatedBy: ";\n\n")
                
                for item in oldArray {
                    let arr = item.components(separatedBy: "\"")
                    if (arr.count > 2) {
                        keyAdd(arr[1])
                    }
                }
//                print(text2)
            }
            catch {/* error handling here */}
        }
    }
    
    /// Used for store text for localization
    ///
    /// - Parameter viewController: current view controller
    func addViewController(_ viewController : UIViewController) {
        weak var weakSelf = viewController
        DispatchQueue.main.async(){
            if let view = weakSelf?.view {
                self.loadView(view)
            }
        }
    }
    
    
    /// Used for check is store mode or used mode
    ///
    /// - Returns: true/false
    func checkISKey() -> Bool {
        if languagePrefrences == "en" {
            return true
        }
        
        return false
    }
    
    /// check all subview view
    ///
    /// - Parameter view: current view
    func loadView(_ view : UIView) {
        for item in view.subviews {
            if item is UITableViewCell || item is UICollectionViewCell {
                return
            } else if item is UILabel {
                if let st = (item as! UILabel).text {
                    
                    //                    item.isUserInteractionEnabled = true
                    //                    let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.addTapView))
                    //                    tapGesture.minimumPressDuration = 0.7
                    //                    item.addGestureRecognizer(tapGesture)
                    
                    if (checkISKey()) {
                        keyAdd(st)
                    } else {
                        (item as! UILabel).text = getLOCText(st)
                    }
                }
            } else if item is UILocalizedUpperCaseButton {
//                    if let st = (item as! UILocalizedUpperCaseButton).title(for: .normal) {
//                        if (checkISKey()) {
//                            keyAdd(st)
//                        } else {
//                            (item as! UILocalizedUpperCaseButton).setTitle(getLOCText(st).uppercased(), for: UIControlState.normal)
//                            (item as! UILocalizedUpperCaseButton).titleLabel?.text = getLOCText(st).uppercased()
//                        }
//                    }
            }  else if item is UIButton {
                if let st = (item as! UIButton).title(for: .normal) {
                    if (checkISKey()) {
                        keyAdd(st)
                    } else {
                        (item as! UIButton).setTitle(getLOCText(st), for: UIControl.State.normal)
                    }
                }
            } else if item is UITextField {
                if let st = (item as! UITextField).placeholder {
                    if (checkISKey()) {
                        keyAdd(st)
                    } else {
                        (item as! UITextField).placeholder = getLOCText(st)
                    }
                }
            } else if item is UITextView {
                if let st = (item as! UITextView).text {
                    if (checkISKey()) {
                        keyAdd(st)
                    } else {
                        (item as! UITextView).text = getLOCText(st)
                    }
                }
            } else if item is UITableView {
//                print(item.subviews.count)
                loadView(item)
            } else {
                loadView(item)
            }
        }
    }
    
    func keyAdd(_ keyStr : String) {
        if (checkISKey()) {
            if (keyStr.count > 0) {
                if !keyDict.contains(keyStr) {
                    keyDict.append(keyStr)
                }
            }
        }
    }
    
    func printKeys() {
        if Platform.isSimulator {
//            print("************&&&&&&&&******************** Strat")
//            print("Localization string ---- \n")
            
            let text : NSMutableString = NSMutableString.init()
            
            for item in keyDict {
                text.append("\"\(item)\" = \"\("")\";\n\n")

//                text.append("\"\(item)\" = \"\(item)\";\n\n")
            }
            
            saveFile(string: text as String)
            
            //        "SHOP" = "TIENDA";
            
//            print("************&&&&&&&&******************** Ent")
        }
    }
    
    func saveFile(string : String) {
        let file = "Localizable.strings" //this is the file. we will write to and read from it
        
        let text = string
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
//                print(text2)
            }
            catch {/* error handling here */}
        }
    }
    
//    func addTapView(_ tapGesture : UITapGestureRecognizer) {
//        if RootViewController.selfObject != nil {
//            colorPicker = ColorPickerViewController.ShowColorPicker(objectAny: tapGesture.view ?? tapGesture, mainViewCont: RootViewController.getRoot().homeNavController.topViewController!)
//        }
//
//    }
}


final class UILocalizedUpperCaseButton: UIButton {
//    override func setTitle(_ title: String?, for state: UIControlState) {
//        let title = self.title(for: .normal)?.getLOCText().uppercased()
//        //setTitle(title, for: state)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.titleLabel?.isAttributed == false {
            self.titleLabel?.textAlignment = .center
            
            let title = self.title(for: .normal)?.getLOCText().uppercased()
            setTitle(title, for: .normal)
        } else {
            self.titleLabel?.localizedAttributedString()
        }
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.titleLabel?.textAlignment = .center
//        self.setTitle(self.titleLabel?.text?.uppercased(), for: UIControlState.normal)
//
//
//        //  self.trailingBuffer = 25
//    }
}


extension UILabel {
    var isAttributed: Bool {
        guard let attributedText = attributedText else { return false }
        let range = NSMakeRange(0, attributedText.length)
        var allAttributes = [Dictionary<NSAttributedString.Key, Any>]()
        attributedText.enumerateAttributes(in: range, options: []) { attributes, _, _ in allAttributes.append(attributes)
        }
        return allAttributes.count > 1
    }
    
    func localizedAttributedString() {
        guard let attributedText = attributedText else { return }
        let mainRange = NSMakeRange(0, attributedText.length)
        
        var newAttributedText : NSMutableAttributedString!
        newAttributedText = NSMutableAttributedString.init()
        attributedText.enumerateAttributes(in: mainRange, options: [], using: { (attributes, range, _) in
            let newStr = attributedText.attributedSubstring(from: range).string.getLOCText()
            newAttributedText.append(NSAttributedString.init(string: newStr, attributes: attributes))
        })
        
        self.attributedText = newAttributedText
        
        //        return allAttributes.count > 1
    }
}
