//
//  MultiSelectionView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/16/22.
//

import SwiftUI

struct MultiSelectionView: View {
    let title: String
    let options: [String]
    
    @Binding var selected: Set<String>
    
    var body: some View {
        List {
            ForEach(options, id: \.self) { selectable in
                Button(action: { toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(selectable)
                            .foregroundColor(.black)
                        Spacer()
                        if selected.contains { $0 == selectable } {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }
                .tag(selectable)
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
    
    private func toggleSelection(selectable: String) {
        if let existingIndex = selected.firstIndex(where: { $0 == selectable }) {
            
            guard selected.count > 1 else { return }
            
            selected.remove(at: existingIndex)
        } else {
            selected.insert(selectable)
        }
    }
}

struct MultiSelectionView_Previews: PreviewProvider {
    @State static var selected: Set<String> = Set(["A", "C"])
    
    static var previews: some View {
        NavigationView {
            MultiSelectionView(
                title: "Preview",
                options: ["A", "B", "C", "D"],
                selected: $selected
            )
        }
    }
}
