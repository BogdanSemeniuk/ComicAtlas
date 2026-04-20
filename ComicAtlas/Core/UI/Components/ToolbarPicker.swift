//
//  ToolbarPicker.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.04.2026.
//

import SwiftUI

struct ToolbarPicker<T: CollectionItemRepresentable>: View where T.AllCases: RandomAccessCollection {
    @Binding var pickerSelection: T
    
    var body: some View {
        Menu {
            Picker(
                selection: $pickerSelection,
                label: EmptyView()
            ) {
                ForEach(T.allCases, id: \.self) {
                    Text($0.description)
                }
            }
        } label: {
            Text(pickerSelection.description)
        }
    }
}

#Preview {
    ToolbarPicker(pickerSelection: .constant(CollectionItem.character))
}
