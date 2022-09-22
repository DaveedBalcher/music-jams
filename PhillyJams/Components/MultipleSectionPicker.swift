//
//  FilterPickersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import SwiftUI

class MultipleSectionViewModel: ObservableObject {
    @Published var sections: [SectionModel]
    
    init(sections: [SectionModel]) {
        self.sections = sections
    }
}

struct MultipleSectionPicker: View {
    var title: String
    @StateObject var vm: MultipleSectionViewModel
    let didComplete: ([String: String?])->Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 86)
                Spacer()
                Text(title)
                    .font(.headline)
                Spacer()
                Button {
                    didComplete(vm.sections.reduce(into: [String : String?]()) { $0[$1.type] = $1.selectedOption })
                } label: {
                    Text("Done")
                }
                .frame(width: 86)
            }
            .padding([.top], 24)
            
            VStack {
                ForEach(0..<vm.sections.count, id:\.self) { index in
                    let section = vm.sections[index]
                    VStack(alignment: .leading) {
                        Text(section.type.capitalized)
                            .fontWeight(.semibold)
                        SectionPicker(options: section.options, selectedOption: $vm.sections[index].selectedOption)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                            .foregroundColor(.white)
                            .shadow(color: Color("32304c").opacity(0.25), radius: 8)
                    )
                    .padding([.leading, .trailing], 12)
                    .padding([.bottom], 8)
                }
                Spacer()
            }
            .padding([.top], 36)
            .background(.regularMaterial)
            

        }
    }
    
    init(vm: MultipleSectionViewModel, title: String, didComplete: @escaping ([String: String?])->Void) {
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
                    SectionModel(type: "Section", displayIndex: 0, options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"]),
                    SectionModel(type: "Section", displayIndex: 0, options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"]),
                    SectionModel(type: "Section", displayIndex: 0, options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"])
                ]
            ),
            title: "Title") { _ in }
    }
}
