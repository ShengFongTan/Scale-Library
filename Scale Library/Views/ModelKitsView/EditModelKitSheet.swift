//
//  EditModelKitSheet.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 12/10/23.
//

import SwiftUI

struct EditModelKitSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Binding var modelKit: ModelKit
    
    @State var modelKitToEdit: ModelKit = ModelKit.emptyModelKit
    
    var body: some View {
        NavigationStack {
            ModelKitFormView(modelKit: $modelKitToEdit)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            do {
                                modelKit.title = modelKitToEdit.title
                                modelKit.shortDescription = modelKitToEdit.shortDescription
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            dismiss()
                        }
                    }
                }
        }
        .onAppear {
            modelKitToEdit.title = modelKit.title
            modelKitToEdit.shortDescription = modelKit.shortDescription
        }
    }
}

#Preview {
    EditModelKitSheet(modelKit: .constant(ModelKit.sampleData[0]))
}
