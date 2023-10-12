//
//  NewModelKitSheet.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 7/10/23.
//

import SwiftUI

struct NewModelKitSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State var modelKitToAdd: ModelKit = ModelKit.emptyModelKit
    
    var body: some View {
        NavigationStack {
            ModelKitFormView(modelKit: $modelKitToAdd)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            context.insert(modelKitToAdd)
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    let preview = PreviewContainer([ModelKit.self])
    return NewModelKitSheet()
        .modelContainer(preview.container)
}
