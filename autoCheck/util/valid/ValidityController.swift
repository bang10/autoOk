//
//  ValidityController.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/23.
//

import Foundation

class ValidityController {
    
    func validateName(name: String) -> Bool {
        let namePattern = "^[가-힣]{2,6}$"
        do {
            let regex = try NSRegularExpression(pattern: namePattern, options: .caseInsensitive)
            let matches = regex.matches(in: name, options: [], range: NSRange(location: 0, length: name.count))
            return matches.count > 0
        } catch {
            return false
        }
    }
    
    func validateEmail(email: String) -> Bool {
        let emailParttern = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailParttern, options: .caseInsensitive)
            let matches = regex.matches(in: email, options: [], range: NSRange(location: 0, length: email.count))
            return matches.count > 0
        } catch {
            return false
        }
    }
    
    func validateTell(tell: String) -> Bool {
        let tellParttern = "^[0-9]{11}$"
            
        do {
            let regex = try NSRegularExpression(pattern: tellParttern, options: .caseInsensitive)
            let matches = regex.matches(in: tell, options: [], range: NSRange(location: 0, length: tell.count))
            return matches.count > 0
        } catch {
            return false
        }
    }
    
    func validatePassword(password: String) -> Bool {
        let passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,15}$"
            
        do {
            let regex = try NSRegularExpression(pattern: passwordPattern, options: .caseInsensitive)
            let matches = regex.matches(in: password, options: [], range: NSRange(location: 0, length: password.count))
            return matches.count > 0
        } catch {
            return false
        }
    }
}
