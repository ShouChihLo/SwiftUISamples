//
//  AccountForm.swift
//  FormValidation
//
//  Created by 羅壽之 on 2023/4/27.
//

import Foundation
import Combine

class AccountForm: ObservableObject {
    
    @Published var email = ""
    @Published var emailValidate = false
    
    @Published var password = ""
    @Published var passwordLengthValidate = false
    @Published var passwordUppercaseValidate = false
    
    @Published var passwordConfirm = ""
    @Published var passwordConfirmValidate = false
    
    private var cancellableSet = Set<AnyCancellable>()
    
    init() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
            }
            .assign(to: \.emailValidate, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 6
            }
            .assign(to: \.passwordLengthValidate, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.passwordUppercaseValidate, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, confirm) in
                return !confirm.isEmpty && (password == confirm)
            }
            .assign(to: \.passwordConfirmValidate, on: self)
            .store(in: &cancellableSet)        
    }
    
    
}

