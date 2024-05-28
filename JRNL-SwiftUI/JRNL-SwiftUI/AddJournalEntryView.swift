//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI
//
//  Created by 황규상 on 5/28/24.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isGetLocationOn: Bool = false
    @State private var entryTitle: String = ""
    @State private var entryBody: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Rating")) {
                    Rectangle()
                        .foregroundColor(.green)
                }
                Section(header: Text("Location")) {
                    Toggle("Get Location", isOn: $isGetLocationOn)
                }
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $entryTitle)
                }
                Section(header: Text("Body")) {
                    TextEditor(text: $entryBody)
                }
                Section(header: Text("Photo")) {
                    
                }
            }
            .navigationTitle("Add Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
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
