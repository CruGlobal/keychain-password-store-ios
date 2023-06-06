//
//  KeychainPasswordStoreExampleApp.swift
//  KeychainPasswordStoreExample
//
//  Created by Levi Eggert on 6/6/23.
//

import SwiftUI

@main
struct KeychainPasswordStoreExampleApp: App {
    var body: some Scene {
        WindowGroup {
            
            
            ContentView(viewModel: ContentViewModel())
        }
    }
}
