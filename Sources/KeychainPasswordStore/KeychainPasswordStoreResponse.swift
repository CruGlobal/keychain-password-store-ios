//
//  KeychainPasswordStoreResponse.swift
//  KeychainPasswordStore
//
//  Created by Levi Eggert on 12/13/22.
//  Copyright © 2022 Cru Global, Inc. All rights reserved.
//

import Foundation
import Security

public enum KeychainPasswordStoreResponse {
    
    case duplicateItem
    case internalError(error: Error)
    case otherStatus(status: OSStatus)
    case success
    
    public var isSuccess: Bool {
        
        switch self {
        
        case .success:
            return true
        
        default:
            return false
        }
    }
    
    public func getMessage() -> String? {
        
        switch self {
        case .duplicateItem:
            return errSecDuplicateItem.getMessage()
            
        case .internalError(let error):
            return error.localizedDescription
            
        case .otherStatus(let status):
            return status.getMessage()
            
        case .success:
            return errSecSuccess.getMessage()
        }
    }
}
