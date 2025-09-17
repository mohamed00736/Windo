//
//  SpacePagerIndicator.swift
//  Windo
//
//  Created by hacinemed on 18/09/2025.
//

 import SwiftUI
struct SpacePagerIndicator: View {
  var currentIndex: Int
  var total: Int
  
  var body: some View {
    HStack(spacing: 8) {
      ForEach(0..<total, id: \.self) { idx in
        Circle()
          .fill(idx == currentIndex ? Color.gray : Color.gray.opacity(0.5))
          .frame(width: 8, height: 8)
      }
    }
  }
}
