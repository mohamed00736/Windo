  //
  //  SpaceListRow.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //


import SwiftUI

struct SpaceListRow: View {
  var space: Space?
  var isHovered: Bool
  
  var body: some View {
    HStack(alignment: .center) {
      if let space = space {
        Image(systemName: "folder.fill")
          .foregroundColor(isHovered ? .black : .black.opacity(0.4)  )
          .foregroundColor(.black.opacity(0.4))
        Text(space.name)
          .foregroundColor(isHovered ? .black : .black.opacity(0.4)  )
          .font(.system(size: 14, weight: .medium))
      } else {
        Image(systemName: "plus")
          .font(.system(size: 14, weight: .medium))
          .foregroundColor(isHovered ? .black : .black.opacity(0.4)  )
        Text("Create space")
          .foregroundColor(isHovered ? .black : .black.opacity(0.4)  )

          .font(.system(size: 14, weight: .medium))
      }
      Spacer()
    }
    .padding(.vertical, 4)
    .padding(.horizontal, 8)
    .background(
      isHovered
      ? AnyShapeStyle(.ultraThinMaterial.opacity(0.3) )
      : AnyShapeStyle(Color.clear)
    )
    .cornerRadius(8)
    .padding(.horizontal, 8)
  }
}
