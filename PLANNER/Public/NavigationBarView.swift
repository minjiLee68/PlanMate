//
//  NavigationBarView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/15.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.dismiss) private var dismiss
    var isSaveButton:(() -> Void) = {}
    let naviTitle: String
    let enumNavi: EnumNavi?
    
    var body: some View {
        ZStack {
            Color.white
            
            HStack(spacing: 0) {
                switch enumNavi {
                case .back:
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .foregroundColor(.black.opacity(0.6))
                            .bold()
                    }
                    
                    Text(naviTitle)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                case .save:
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .foregroundColor(.black.opacity(0.6))
                            .bold()
                    }
                    
                    Text(naviTitle)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        isSaveButton()
                    } label: {
                        Text("Save")
                            .foregroundColor(.black.opacity(0.6))
                            .bold()
                    }

                default:
                    Text("")
                }
                
                Spacer()
            }
        }
        .frame(height: 44)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(isSaveButton: {}, naviTitle: "TASK TEST", enumNavi: .back)
    }
}
