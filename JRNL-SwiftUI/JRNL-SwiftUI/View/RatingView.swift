//
//  RatingView.swift
//  JRNL-SwiftUI
//
//  Created by 황규상 on 5/29/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = index + 1
                    }
            }
        }
    }
}
