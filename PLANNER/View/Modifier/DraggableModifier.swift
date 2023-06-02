//
//  DraggableModifier.swift
//  PLANNER
//
//  Created by 이민지 on 2023/06/02.
//

import SwiftUI

struct DraggableModifier: ViewModifier {
    enum Direction {
        case vertical
        case horizontal
    }
    
    let direction: Direction
    
    @State private var draggedOffset: CGSize = .zero
    
    @Binding var showDeleteAlert: Bool
    @Binding var dragMode: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(
                CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                       height: direction == .horizontal ? 0 : draggedOffset.height)
            )
            .gesture (
                DragGesture()
                    .onChanged { gesture in
                        withAnimation(.easeIn) {
                            if gesture.translation.width > 0 {
                                self.draggedOffset = .zero
                            } else {
                                self.draggedOffset = gesture.translation
                            }
                        }
                        
                        if gesture.translation.width < -200 {
                            showDeleteAlert = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut) {
                            if self.draggedOffset.width < -50 {
                                self.draggedOffset.width = -60
                            } else {
                                self.draggedOffset = .zero
                            }
                        }
                    }
            )
            .onChange(of: dragMode, perform: { _ in
                withAnimation(.easeOut) {
                    self.draggedOffset = .zero
                }
            })
    }
}
