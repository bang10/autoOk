//
//  Alert.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/23.
//

import Foundation
import UIKit

class Alert {
    
    init(){}
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
