//
//  BubbleView.swift
//  BubbleWrap
//
//  Created by Stephen Ceresia on 2020-04-13.
//  Copyright © 2020 Stephen Ceresia. All rights reserved.
//
import SwiftUI

struct Bubble: View {
    @EnvironmentObject var model: ContentViewModel
    @State var isPopped: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.handlePop()
            }) {
                Image(systemName: self.isPopped ? "circle" : "largecircle.fill.circle")
                    .foregroundColor(bubbleColor())
                    .font(.system(size: 60))
            }
        }.onAppear {
            self.model.bubbles.append(self)
        }
        
    }
    
    func handlePop() {
        if !self.isPopped {
            self.isPopped = true
            self.model.score += 1
            playSound()
        }
    }
    
    func bubbleColor() -> Color {
        switch model.score {
        case 0..<10:
            return .blue
        case 10..<20:
            return Color(.magenta)
        case 20..<30:
            return Color(.green)
        case 30..<40:
            return Color(.red)
        case 40..<50:
            return Color(.cyan)
        case 50..<60:
            return .orange
        case 60..<70:
            return .purple
        case 70..<80:
            return .gray
        case 80..<90:
            return Color(.brown)
        case 90..<100:
            return .primary
        default:
            return Color(.yellow)
        }
    }
    
}
