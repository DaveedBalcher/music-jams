//
//  FilterView.swift
//  MusicJams (iOS)
//
//  Created by Daveed Balcher on 8/1/22.
//

import SwiftUI

struct ToggleView<Selectable: Hashable>: View {
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    
    @Binding var selected: Selectable
    
    var body: some View {
        HStack {
            switch options.count {
            case 0:
                fatalError("Can not have empty options")
            case 1:
                Text(optionToString(options.first!))
                    .padding(2)
            default:
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(optionToString(option))
                            .tag(option)
                    }
                }
            }
        }
        .font(.system(size: 15))
        .padding([.leading, .trailing], 12)
        .background(Capsule().strokeBorder(.secondary))
        .frame(idealHeight: 44)
    }
}

struct ToggleView_Previews: PreviewProvider {
    struct IdentifiableString: Hashable {
        let string: String
        var id: String { string }
    }
    
    @State static var selected = IdentifiableString(string: "A")
    
    static var previews: some View {
        NavigationView {
            Form {
                ToggleView<IdentifiableString>(
                    options:  ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                    optionToString: { $0.string },
                    selected: $selected
                )
            }.navigationTitle("Title")
        }
    }
}
