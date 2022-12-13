//
//  OSStatus+KeychainPasswordStoreResponse.swift
//  KeychainPasswordStore
//
//  Created by Levi Eggert on 12/13/22.
//  Copyright © 2022 Cru Global, Inc. All rights reserved.
//

import Foundation
import Security

extension OSStatus {
    
    public func getKeychainPasswordStoreResponse() -> KeychainPasswordStoreResponse {
        
        if self == errSecSuccess {
            return .success
        }
        else if self == errSecDuplicateItem {
            return .duplicateItem
        }
        
        return .otherStatus(status: self)
    }
}
