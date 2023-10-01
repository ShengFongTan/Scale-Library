//
//  ModelsCard.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 30/9/23.
//

import SwiftUI

struct ModelsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("model-kits")
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 200)
                .clipped()
                .overlay(
                    Text("1:48")
                        .bold()
                        .foregroundColor(Color.black)
                        .padding([.leading, .trailing], 16)
                        .padding([.top, .bottom], 8)
                        .background(Color.yellow.opacity(0.8))
                        .clipShape(.rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 0
                        )),
                    alignment: .topLeading
                )
            
            VStack(alignment: .leading, spacing: 10) {
                Text("F-35B")
                    .font(.title3)
                    .fontWeight(Font.Weight.heavy)
                Text("Bunch of random text here")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color.gray)
                
                HStack(alignment: .center, spacing: 6) {
                    Group {
                        Text("Tamiya")
                            .font(Font.custom("HelveticaNeue-Medium", size: 12))
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                            .foregroundColor(Color.white)
                    }
                    .background(Color(red: 43/255, green: 175/255, blue: 187/255))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    Group {
                        Text("Aircraft")
                            .font(Font.custom("HelveticaNeue-Medium", size: 12))
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                            .foregroundColor(Color.white)
                    }
                    .background(Color(red: 43/255, green: 175/255, blue: 187/255))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                }
                .padding([.bottom], 5)
                
                Divider()
                
                HStack(alignment: .center, spacing: 4) {
                    Text("Bought on")
                        .font(.footnote)
                    Text("27 June 2020")
                        .font(.footnote)
                        .bold()
                    Spacer()
                    Text("$55")
                        .fontWeight(Font.Weight.heavy)
                }
                .padding([.bottom], 10)
            }
            .padding([.leading, .trailing])
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5)
    }
}

#Preview {
    ModelsCard()
}
