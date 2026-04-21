//
//  ToolbarPicker.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.04.2026.
//

import SwiftUI

struct ToolbarPicker<T: CollectionItemRepresentable, Label: View>: View where T.AllCases: RandomAccessCollection {
    @Binding var pickerSelection: T
    var label: Label
    
    init(
        pickerSelection: Binding<T>,
        @ViewBuilder label: () -> Label
    ) {
        self.label = label()
        self._pickerSelection = pickerSelection
    }
    
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
            label
        }
    }
}

#Preview {
    ToolbarPicker(
        pickerSelection: .constant(CollectionItem.character),
        label: { Text("Sort by:") }
    )
}
