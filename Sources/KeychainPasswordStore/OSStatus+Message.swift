//
//  OSStatus+Message.swift
//  KeychainPasswordStore
//
//  Created by Levi Eggert on 12/13/22.
//  Copyright © 2022 Cru Global, Inc. All rights reserved.
//

import Foundation
import Security

extension OSStatus {
    
    public func getMessage() -> String? {
        
        let message: String?
        
        if let cfString = SecCopyErrorMessageString(self, nil) {
            message = cfString as String
        }
        else {
            message = nil
        }
        
        return message
    }
}
