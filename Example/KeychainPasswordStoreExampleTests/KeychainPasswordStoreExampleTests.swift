//
//  KeychainPasswordStoreExampleTests.swift
//  KeychainPasswordStoreExampleTests
//
//  Created by Levi Eggert on 6/6/23.
//

import Foundation
import Testing
import KeychainPasswordStore

struct KeychainPasswordStoreExampleTests {
    
    @Test()
    func storePasswordExists() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let newPassword: String = "test-password-a"
        
        let storeResponse: KeychainPasswordStoreResponse = keychainStore.storePassword(account: account, password: newPassword, overwriteExisting: true)
        
        #expect(storeResponse.isSuccess == true)
                
        let existingPassword: String? = keychainStore.getPassword(account: account)
                
        #expect(newPassword == existingPassword)
    }
    
    @Test()
    func storePasswordWithOverwriteFalseIsNotChanged() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let originalPassword: String = "original-password"
        let newPassword: String = "new-password"
        
        _ = keychainStore.storePassword(account: account, password: originalPassword, overwriteExisting: true)
        
        #expect(originalPassword == keychainStore.getPassword(account: account))
        
        _ = keychainStore.storePassword(account: account, password: newPassword, overwriteExisting: false)
        
        #expect(newPassword != keychainStore.getPassword(account: account))
        
        #expect(originalPassword == keychainStore.getPassword(account: account))
    }
    
    @Test()
    func storePasswordWithOverwriteTrueIsChanged() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let originalPassword: String = "original-password"
        let newPassword: String = "new-password"
        
        _ = keychainStore.storePassword(account: account, password: originalPassword, overwriteExisting: true)
        
        #expect(originalPassword == keychainStore.getPassword(account: account))
        
        _ = keychainStore.storePassword(account: account, password: newPassword, overwriteExisting: true)
        
        #expect(originalPassword != keychainStore.getPassword(account: account))
        
        #expect(newPassword == keychainStore.getPassword(account: account))
    }
    
    @Test()
    func updatePassword() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let originalPassword: String = "original-password"
        let newPassword: String = "updated-password"
        
        _ = keychainStore.storePassword(account: account, password: originalPassword, overwriteExisting: true)
        
        #expect(originalPassword == keychainStore.getPassword(account: account))
        
        _ = keychainStore.updatePassword(account: account, password: newPassword)
                
        #expect(newPassword == keychainStore.getPassword(account: account))
    }
    
    @Test()
    func deletedPassword() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let password: String = "original-password"
        
        _ = keychainStore.storePassword(account: account, password: password, overwriteExisting: true)
        
        #expect(password == keychainStore.getPassword(account: account))
        
        _ = keychainStore.deletePassword(account: account)
                
        #expect(keychainStore.getPassword(account: account) == nil)
    }
}

extension KeychainPasswordStoreExampleTests {
    
    private func getRandomKeychainStore() -> KeychainPasswordStore {
        
        let randomService: String = UUID().uuidString
        
        return KeychainPasswordStore(service: randomService)
    }
}
