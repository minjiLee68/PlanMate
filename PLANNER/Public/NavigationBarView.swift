//
//  NavigationBarView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/15.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.dismiss) private var dismiss
    let naviTitle: String
    let enumNavi: EnumNavi?
    
    var body: some View {
        ZStack {
            Color.white
            
            HStack(spacing: 0) {
                switch enumNavi {
                case .dismiss:
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .foregroundColor(.black.opacity(0.6))
                            .bold()
                    }
                default:
                    Text("")
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Text(naviTitle)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(naviTitle: "TASK TEST", enumNavi: .dismiss)
    }
}
