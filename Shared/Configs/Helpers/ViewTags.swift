//
//  ViewTags.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 07.06.22.
//

import SwiftUI

struct tags: View {
    var tags: Array<String>
    var body: some View {
        HStack {
        ForEach(tags, id: \.self) { e in
            Text(e)
                .foregroundColor(.pink)
                .font(.system(size: 6))
                .padding(4)
                .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.pink, lineWidth: 0.5)
               )
           }
        }
    }
}
