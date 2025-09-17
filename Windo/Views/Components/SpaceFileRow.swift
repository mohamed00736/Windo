//
//  SpaceFileRow.swift
//  Windo
//
//  Created by hacinemed on 17/09/2025.
//


import SwiftUI

struct SpaceFileRow: View {
    var file: SpaceFile
    var isHovered: Bool

    var iconName: String {
        switch file.fileExtension {
        case "doc": return "doc.fill"
        case "pdf": return "doc.richtext"
        case "img": return "photo"
        case "mic": return "mic"
        case "chat": return "bubble.left"
        case "cal": return "calendar"
        case "web": return "globe"
        case "unknown": return "doc"
        default: return "doc"
        }
    }

    var iconColor: Color {
        switch file.fileExtension {
        case "doc": return .blue
        case "pdf": return .green
        case "img": return .yellow
        case "mic": return .red
        case "chat": return .cyan
        case "cal": return .blue
        case "web": return .purple
        case "unknown": return .gray
        default: return .gray
        }
    }

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(file.name)
            .foregroundColor(isHovered ? .black : .black.opacity(0.4)  )
            .font(.system(size: 14, weight: .medium))
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(
          isHovered
          ? AnyShapeStyle(.black.opacity(0.1) )
          : AnyShapeStyle(Color.clear)
        )
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}
