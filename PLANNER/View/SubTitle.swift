//
//  SubTitle.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI

struct SubTitle: View {
    @State var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 5)
    }
}

struct SubTitle_Previews: PreviewProvider {
    static var previews: some View {
        SubTitle(title: "")
    }
}
