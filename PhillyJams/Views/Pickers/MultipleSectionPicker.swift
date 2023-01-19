//
//  FilterPickersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import SwiftUI

extension SectionViewModel {
    static func mapFromFilters(filterOptions: [String : [String]], filterSelected: [String: [String]]) -> [SectionViewModel] {
        [
            SectionViewModel(type: "types", options: filterOptions["types"] ?? [], selectedOption: filterSelected["types"] ?? []),
            SectionViewModel(type: "genres", options: filterOptions["genres"] ?? [], selectedOption: filterSelected["genres"] ?? []),
            SectionViewModel(type: "vibes", options: filterOptions["vibes"] ?? [], selectedOption: filterSelected["vibes"] ?? []),
            SectionViewModel(type: "urgency", options: filterOptions["urgency"] ?? [], selectedOption: filterSelected["urgency"] ?? [])
        ].filter { !$0.options.isEmpty }
    }
}

struct MultipleSectionPicker: View {
    var title: String
    @StateObject var vm: MultipleSectionViewModel
    let didComplete: ([String: [String]])->Void

    var body: some View {
        NavigationView {
            VStack {
                ForEach(0..<vm.sections.count, id:\.self) { index in
                    let section = vm.sections[index]
                    VStack(alignment: .leading) {
                        Text(section.type.capitalized)
                            .fontWeight(.semibold)
                        SectionPicker(vm: section)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                            .foregroundColor(.white)
                            .shadow(color: Color.accentColor.opacity(0.25), radius: 8)
                    )
                    .padding([.leading, .trailing], 12)
                    .padding([.bottom], 8)
                }
                Spacer()
            }
            .padding([.top], 12)
            .background(.regularMaterial)
            .navigationBarTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        didComplete(vm.selectedOptions)
                    } label: {
                        Text("Done")
                            .foregroundColor(Color.lightBlue)
                    }
                }
            }
        }
    }

    init(vm: MultipleSectionViewModel, title: String, didComplete: @escaping ([String: [String]])->Void) {
        _vm = StateObject(wrappedValue: vm)
        self.title = title
        self.didComplete = didComplete
    }
}

struct FilterPickersView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSectionPicker(
            vm: MultipleSectionViewModel(
                sections: [
                    SectionViewModel(type: "Section", options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"]),
                    SectionViewModel(type: "Section", options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"]),
                    SectionViewModel(type: "Section", options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"])
                ]
            ),
            title: "Title") { _ in }
    }
}
