//
//  KeychainPasswordStoreExampleTests.swift
//  KeychainPasswordStoreExampleTests
//
//  Created by Levi Eggert on 6/6/23.
//

import XCTest
import KeychainPasswordStore

final class KeychainPasswordStoreExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func getRandomKeychainStore() -> KeychainPasswordStore {
        
        let randomService: String = UUID().uuidString
        
        return KeychainPasswordStore(service: randomService)
    }
    
    func testStorePasswordExists() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let newPassword: String = "test-password-a"
        
        let storeResponse: KeychainPasswordStoreResponse = keychainStore.storePassword(account: account, password: newPassword, overwriteExisting: true)
        
        XCTAssertEqual(storeResponse.isSuccess, true)
        
        let existingPassword: String? = keychainStore.getPassword(account: account)
                
        XCTAssertEqual(newPassword, existingPassword)
    }
    
    func testStorePasswordWithOverwriteFalseIsNotChanged() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let originalPassword: String = "original-password"
        let newPassword: String = "new-password"
        
        _ = keychainStore.storePassword(account: account, password: originalPassword, overwriteExisting: true)
        
        XCTAssertEqual(originalPassword, keychainStore.getPassword(account: account))
        
        _ = keychainStore.storePassword(account: account, password: newPassword, overwriteExisting: false)
        
        XCTAssertNotEqual(newPassword, keychainStore.getPassword(account: account))
        
        XCTAssertEqual(originalPassword, keychainStore.getPassword(account: account))
    }
    
    func testStorePasswordWithOverwriteTrueIsChanged() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let originalPassword: String = "original-password"
        let newPassword: String = "new-password"
        
        _ = keychainStore.storePassword(account: account, password: originalPassword, overwriteExisting: true)
        
        XCTAssertEqual(originalPassword, keychainStore.getPassword(account: account))
        
        _ = keychainStore.storePassword(account: account, password: newPassword, overwriteExisting: true)
        
        XCTAssertNotEqual(originalPassword, keychainStore.getPassword(account: account))
        
        XCTAssertEqual(newPassword, keychainStore.getPassword(account: account))
    }
    
    func testUpdatePassword() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let originalPassword: String = "original-password"
        let newPassword: String = "updated-password"
        
        _ = keychainStore.storePassword(account: account, password: originalPassword, overwriteExisting: true)
        
        XCTAssertEqual(originalPassword, keychainStore.getPassword(account: account))
        
        _ = keychainStore.updatePassword(account: account, password: newPassword)
                
        XCTAssertEqual(newPassword, keychainStore.getPassword(account: account))
    }
    
    func testDeletedPassword() {
        
        let keychainStore: KeychainPasswordStore = getRandomKeychainStore()
        
        let account: String = "test-account"
        let password: String = "original-password"
        
        _ = keychainStore.storePassword(account: account, password: password, overwriteExisting: true)
        
        XCTAssertEqual(password, keychainStore.getPassword(account: account))
        
        _ = keychainStore.deletePassword(account: account)
                
        XCTAssertNil(keychainStore.getPassword(account: account))
    }
}
