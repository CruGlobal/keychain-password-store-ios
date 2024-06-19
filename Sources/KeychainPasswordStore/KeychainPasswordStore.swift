//
//  KeychainPasswordStore.swift
//  KeychainPasswordStore
//
//  Created by Levi Eggert on 12/13/22.
//  Copyright © 2022 Cru Global, Inc. All rights reserved.
//

import Foundation
import Security

public class KeychainPasswordStore {
    
    private let service: String
    
    public init(service: String) {
        
        self.service = service
    }
    
    public func getPassword(account: String) -> String? {
        
        let searchPasswordQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var typeRef: CFTypeRef?
        
        let status: OSStatus = SecItemCopyMatching(searchPasswordQuery as CFDictionary, &typeRef)
        
        guard status == errSecSuccess, let typeRef = typeRef, let items = typeRef as? [[String: Any]] else {
            return nil
        }
        
        guard let firstItem = items.first,
              let data = firstItem[kSecValueData as String] as? Data,
              let password = String(data: data, encoding: String.Encoding.utf8) else {
              
            return nil
        }
        
        return password
    }
    
    public func storePassword(account: String, password: String, overwriteExisting: Bool) -> KeychainPasswordStoreResponse {
        
        guard let passwordData = password.data(using: String.Encoding.utf8) else {
            let error: Error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode password: String to Data."])
            return .internalError(error: error)
        }
        
        let storePasswordQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: passwordData
        ]
        
        var typeRef: CFTypeRef?
        
        let storePasswordStatus: OSStatus = SecItemAdd(storePasswordQuery as CFDictionary, &typeRef)
                        
        if storePasswordStatus == errSecDuplicateItem && overwriteExisting {
                       
            let updateResponse: KeychainPasswordStoreResponse = updatePassword(account: account, password: password)
            
            return updateResponse
        }
        
        return storePasswordStatus.getKeychainPasswordStoreResponse()
    }
    
    public func updatePassword(account: String, password: String) -> KeychainPasswordStoreResponse {
        
        guard let passwordData = password.data(using: String.Encoding.utf8) else {
            let error: Error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode password: String to Data."])
            return .internalError(error: error)
        }
        
        let updatePasswordQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let updatePasswordAttributes: [String: Any] = [
            kSecAttrAccount as String: account,
            kSecValueData as String: passwordData
        ]
        
        let updateStatus: OSStatus = SecItemUpdate(
            updatePasswordQuery as CFDictionary,
            updatePasswordAttributes as CFDictionary
        )
        
        return updateStatus.getKeychainPasswordStoreResponse()
    }
    
    public func deletePassword(account: String) -> KeychainPasswordStoreResponse {
        
        let deletePasswordQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let deleteStatus: OSStatus = SecItemDelete(deletePasswordQuery as CFDictionary)
        
        return deleteStatus.getKeychainPasswordStoreResponse()
    }
}
