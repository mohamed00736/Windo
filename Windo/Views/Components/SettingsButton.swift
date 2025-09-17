//
//  SettingsButton.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import SwiftUI

struct GeneralButton: View {
  
  var image : String
    var body: some View {
        Image(systemName: image)
            .font(.title2)
            .foregroundColor(.gray)
            .opacity(0.7)
    }
}


