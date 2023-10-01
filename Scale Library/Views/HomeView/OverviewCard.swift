//
//  OverviewCard.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 26/9/23.
//

import SwiftUI

struct OverviewCard: View {
    
    let icon: String
    let title: String
    let smallText: String
    let count: Int
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("TwitterBlue"))
                Image(systemName: "\(icon)")
                    .foregroundColor(.white)
                    .imageScale(.large)
            }
            .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text("\(title)")
                    .font(.headline)
                Text("\(smallText)")
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(count)")
                    .font(.title2)
                    .bold()
            }
        }
    }
}

#Preview {
    OverviewCard(
        icon: "shippingbox",
        title: "Title",
        smallText: "Some text here",
        count: 15
    )
}
