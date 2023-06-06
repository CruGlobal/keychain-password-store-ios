//
//  ContentViewModel.swift
//  KeychainPasswordStoreExample
//
//  Created by Levi Eggert on 6/6/23.
//

import Foundation
import KeychainPasswordStore

class ContentViewModel: ObservableObject {
    
    private let keychainStore: KeychainPasswordStore = KeychainPasswordStore(service: "keychain-password-store-example")
    private let userIdAccount: String = "user_id_account"
    private let userPasswordAccount: String = "user_password_account"
    
    @Published var userId: String = ""
    @Published var userPassword: String = ""
    
    init() {
        
        //keychainStore.storePassword(account: userIdAccount, password: "user_a", overwriteExisting: true)
        //keychainStore.storePassword(account: userPasswordAccount, password: "password_a", overwriteExisting: true)
        
        reloadUserIdAndPassword()
    }
    
    private func reloadUserIdAndPassword() {
        
        userId = keychainStore.getPassword(account: userIdAccount) ?? "no user id"
        userPassword = keychainStore.getPassword(account: userPasswordAccount) ?? "no user password"
    }
}
