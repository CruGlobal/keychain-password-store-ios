//
//  ContentView.swift
//  KeychainPasswordStoreExample
//
//  Created by Levi Eggert on 6/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Text("KeychainPasswordStore")
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0))
                        
            Text(viewModel.userId)
                .font(Font.system(size: 17))
                .foregroundColor(Color.black)
            
            Text(viewModel.userPassword)
                .font(Font.system(size: 17))
                .foregroundColor(Color.black)
        }
    }
}
