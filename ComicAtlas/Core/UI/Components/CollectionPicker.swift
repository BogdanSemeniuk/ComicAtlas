//
//  CollectionPicker.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import SwiftUI

struct CollectionPicker<T: Identifiable & CustomStringConvertible & CaseIterable & Equatable>: View {
    @Binding var selected: T
    private let height: CGFloat = 60
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(T.allCases)) { item in
                    itemView(for: item)
                }
            }
        }
        .frame(height: height)
        .scrollIndicators(.hidden)
        .animation(.smooth, value: selected)
    }
    
    private func itemView(for item: T) -> some View {
        Text(item.description)
            .frame(width: 110, height: height)
            .font(.body.weight(selected == item ? .black : .bold))
            .foregroundStyle(selected == item ? .white : .textPrimary)
            .background(
                Color(selected == item ? .brandPrimary : .background),
                in: .capsule
            )
            .overlay {
                Capsule()
                    .stroke(
                        Color(.brandPrimary),
                        lineWidth: selected == item ? 0 : 2
                    )
            }
            .padding(.vertical, 2)
            .contentShape(.rect)
            .onTapGesture {
                selected = item
            }
    }
}

#Preview {
    @Previewable @State var selection: CollectionItem = .character
    CollectionPicker(selected: $selection)
}
