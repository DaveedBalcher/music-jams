//
//  MultiSelectionView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/16/22.
//

import SwiftUI

struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
    let title: String
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    
    @Binding var selected: Set<Selectable>
    
    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: { toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(optionToString(selectable)).foregroundColor(.black)
                        Spacer()
                        if selected.contains { $0.id == selectable.id } {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }
                .tag(selectable.id)
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear {
            if selected.isEmpty {
                selected = Set(options)
            }
        }
        .navigationTitle(title)
    }
    
    private func toggleSelection(selectable: Selectable) {
        if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            
            guard selected.count > 1 else { return }
            
            selected.remove(at: existingIndex)
        } else {
            selected.insert(selectable)
        }
    }
}

struct MultiSelectionView_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }
    
    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })
    
    static var previews: some View {
        NavigationView {
            MultiSelectionView(
                title: "Preview",
                options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                optionToString: { $0.string },
                selected: $selected
            )
        }
    }
}
