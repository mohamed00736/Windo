//
//  SpaceHeaderView.swift
//  Windo
//
//  Created by hacinemed on 18/09/2025.
//

import SwiftUI

struct SpaceHeaderView: View {
  @Binding var back: Bool
  var spaceName: String
  
  var body: some View {
    HStack {
      Button(action: { back = true }) {
        Image(systemName: "arrow.left")
          .font(.title2)
          .foregroundColor(.black)
      }
      .buttonStyle(PlainButtonStyle())
      Text(spaceName)
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(.black)
    }
    .padding(.top, 8)
    .padding(.leading, 24)
  }
}
