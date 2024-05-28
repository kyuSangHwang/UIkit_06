//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI
//
//  Created by 황규상 on 5/28/24.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Text("Add JournalEntry")
                .navigationTitle("Add Journal Entry")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Save") {
                            dismiss()
                        }
                    }
                }
        }
        .navigationTitle("")
    }
}

#Preview {
    AddJournalEntryView()
}
