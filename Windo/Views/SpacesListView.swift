  //
  //  SpacesListView.swift
  //  Windo
  //
  //  Created by hacinemed on 17/09/2025.
  //


import SwiftUI


struct SpacesListView: View {
  @EnvironmentObject var viewModel: SpacesViewModel
  @State private var hoveredIndex: Int? = nil
  @State private var isHovered: Bool = false
  @State private var isWindowCursor: Bool = false
  
  var body: some View {
    
    ZStack(alignment: .bottomLeading) {
      VStack(alignment: .leading) {
        Text("Spaces")
          .font(.system(size: 20, weight: .bold))
          .padding(.top, 8)
          .padding(.leading, 24)
          .foregroundColor(.black)
        Divider().background(.gray.opacity(0.3))
  
          .padding(.horizontal,16)
        ForEach(Array(viewModel.spaces.enumerated()), id: \.element.id) { idx, space in
          SpaceListRow(space: space, isHovered: hoveredIndex == idx)
            .onHover { inside in
              hoveredIndex = inside ? idx : nil
              isHovered = inside
            }
            .onTapGesture {
              withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectedSpace = space
              }
            }
        }
        if isWindowCursor {
          SpaceListRow(space: nil, isHovered: false) // "Create space" row
        }
        Spacer()
      }
     
      GeneralButton(image:  "slider.horizontal.3"
      )
        .padding(.bottom, 16)
        .padding(.leading, 16)
    }
  
    
    .background(
      ZStack {
        Rectangle.semiOpaqueWindow()
        .cornerRadius(0)
        Color.white.opacity(0.44)
      }
      
    )
    .onHover { iiu in
      isWindowCursor = iiu
    }
  }
    
    
}

