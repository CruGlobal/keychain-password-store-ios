//
//  KeychainPasswordStoreTests.swift
//  ExampleTests
//
//  Created by Levi Eggert on 2/24/23.
//

import XCTest
import KeychainPasswordStore

final class KeychainPasswordStoreTests: XCTestCase {

    enum KeychainService: String {
        
        case a = "a"
        case b = "b"
        case c = "c"
        case main = "main"
        
        func getStore() -> KeychainPasswordStore {
            return KeychainPasswordStore(service: rawValue)
        }
    }
    
    enum KeychainAccount: String {
        
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
        case name = "name"
        case password = "password"
    }
    
    let mainStore: KeychainPasswordStore = KeychainService.main.getStore()
        
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSavingPasswordExists() {
        
        let account: String = KeychainAccount.password.rawValue
        let password: String = "password123"
        
        _ = mainStore.storePassword(account: account, password: password, overwriteExisting: true)
                
        XCTAssertTrue(mainStore.getPassword(account: account) == password)
    }
    
    func testDeletingPasswordNoLongerExists() {
        
        let account: String = KeychainAccount.password.rawValue
        let password: String = "password123"
        
        _ = mainStore.storePassword(account: account, password: password, overwriteExisting: true)
                
        XCTAssertTrue(mainStore.getPassword(account: account) == password)
        
        _ = mainStore.deletePassword(account: account)
        
        XCTAssertNil(mainStore.getPassword(account: account))
    }
    
    func testUpdatingExistingPasswordIsChangedToNewValue() {
        
        let account: String = KeychainAccount.password.rawValue
        let password: String = "password123"
        let newPassword: String = "swo4i5lD5fep"
        
        _ = mainStore.storePassword(account: account, password: password, overwriteExisting: true)
                
        XCTAssertTrue(mainStore.getPassword(account: account) == password)
        
        _ = mainStore.updatePassword(account: account, password: newPassword)
                
        XCTAssertTrue(mainStore.getPassword(account: account) == newPassword)
    }
    
    func testStoringPasswordsInMultipleAccountsUnderSingleService() {
        
        let passwords: [KeychainAccount: String] = [
            KeychainAccount.a: "password_a",
            KeychainAccount.b: "password_b",
            KeychainAccount.c: "password_c",
            KeychainAccount.d: "password_d"
        ]
        
        _ = mainStore.storePassword(account: KeychainAccount.a.rawValue, password: passwords[.a]!, overwriteExisting: true)
        _ = mainStore.storePassword(account: KeychainAccount.b.rawValue, password: passwords[.b]!, overwriteExisting: true)
        _ = mainStore.storePassword(account: KeychainAccount.c.rawValue, password: passwords[.c]!, overwriteExisting: true)
        _ = mainStore.storePassword(account: KeychainAccount.d.rawValue, password: passwords[.d]!, overwriteExisting: true)
        
        XCTAssertTrue(mainStore.getPassword(account: KeychainAccount.a.rawValue) == passwords[.a])
        XCTAssertTrue(mainStore.getPassword(account: KeychainAccount.b.rawValue) == passwords[.b])
        XCTAssertTrue(mainStore.getPassword(account: KeychainAccount.c.rawValue) == passwords[.c])
        XCTAssertTrue(mainStore.getPassword(account: KeychainAccount.d.rawValue) == passwords[.d])
        
        _ = mainStore.deletePassword(account: KeychainAccount.a.rawValue)
        _ = mainStore.deletePassword(account: KeychainAccount.b.rawValue)
        _ = mainStore.deletePassword(account: KeychainAccount.c.rawValue)
        _ = mainStore.deletePassword(account: KeychainAccount.d.rawValue)
        
        XCTAssertNil(mainStore.getPassword(account: KeychainAccount.a.rawValue))
        XCTAssertNil(mainStore.getPassword(account: KeychainAccount.b.rawValue))
        XCTAssertNil(mainStore.getPassword(account: KeychainAccount.c.rawValue))
        XCTAssertNil(mainStore.getPassword(account: KeychainAccount.d.rawValue))
    }
    
    func testStoringPasswordsWithSameAccountInDifferentServicesDontConflict() {
        
        let storeA: KeychainPasswordStore = KeychainService.a.getStore()
        let storeB: KeychainPasswordStore = KeychainService.b.getStore()
        
        let sameAccountName: String = "duplicate_account"
        
        let passwordA: String = "passwordA"
        let passwordB: String = "passwordB"
        
        _ = storeA.storePassword(account: sameAccountName, password: passwordA, overwriteExisting: true)
        _ = storeB.storePassword(account: sameAccountName, password: passwordB, overwriteExisting: true)
        
        XCTAssertTrue(storeA.getPassword(account: sameAccountName) == passwordA)
        XCTAssertTrue(storeB.getPassword(account: sameAccountName) == passwordB)
        
        _ = storeA.deletePassword(account: sameAccountName)
        
        XCTAssertNil(storeA.getPassword(account: sameAccountName))
        XCTAssertNotNil(storeB.getPassword(account: sameAccountName))
        
        _ = storeB.deletePassword(account: sameAccountName)
        
        XCTAssertNil(storeB.getPassword(account: sameAccountName))
    }
}
