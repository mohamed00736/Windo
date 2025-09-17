//
//  SpacePagerView.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import SwiftUI
import SwiftUI


struct SpacePagerView: View {
    let files: [SpaceFile]
    @Binding var selectedIndex: Int

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(Array(files.enumerated()), id: \.element.id) { idx, file in
                    SpaceFileRow(file: file, isHovered: false) 
                        .frame(width: 340)
                        .opacity(selectedIndex == idx ? 1 : 0.3)
                        .animation(.easeInOut, value: selectedIndex)
                }
            }
            .frame(width: 340, height: 340)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 && selectedIndex < files.count - 1 {
                            selectedIndex += 1
                        }
                        if value.translation.width > 50 && selectedIndex > 0 {
                            selectedIndex -= 1
                        }
                    }
            )

            //indicator
            HStack(spacing: 8) {
                ForEach(0..<files.count, id: \.self) { idx in
                    Circle()
                        .fill(idx == selectedIndex ? Color.primary : Color.secondary.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 8)
        }
    }
}
