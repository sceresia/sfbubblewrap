//
//  ContentView.swift
//  BubbleWrap
//
//  Created by Stephen Ceresia on 2020-04-12.
//  Copyright © 2020 Stephen Ceresia. All rights reserved.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer?
let path = Bundle.main.path(forResource: "pop", ofType:"mp3")!
let url = URL(fileURLWithPath: path)

func inititializeAudioPlayer() {
    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
    } catch {
        print(error.localizedDescription)
    }
}

func playSound() {
    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    } catch {
        print(error.localizedDescription)
    }
}

class ContentViewModel: ObservableObject {
    @Published var bubbles = [Bubble]()
    @Published var score = 0
    
    init() {
        inititializeAudioPlayer()
    }
}

struct ContentView: View {
    @EnvironmentObject var model: ContentViewModel
    
    @State private var level = 0
    var levels = ["20", "40", "100"]
    
    var rows:Int {
        switch level {
        case 0:
            return 5
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 8
        }
    }
    var columns:Int {
        switch level {
        case 0:
            return 4
        case 1:
            return 5
        case 2:
            return 5
        default:
            return 5
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("SCORE: \(model.score)")
                        .font(.largeTitle).fontWeight(.black)
                        .padding()
                    
                    Picker(selection: $level, label: Text("")) {
                        ForEach(0..<levels.count) { index in
                            Text(self.levels[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    ForEach((1...rows), id: \.self) { row in
                        HStack {
                            ForEach((1...self.columns), id: \.self) { column in
                                Bubble()
                                    .padding(.bottom)
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            self.resetGrid()
                        }) {
                            Text("RESET GRID")
                                .padding()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .background(Color(.orange))
                                .cornerRadius(10)
                            
                        }
                        .padding()
                        
                        Button(action: {
                            self.resetScore()
                        }) {
                            Text("RESET SCORE")
                                .padding()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .background(Color(.red))
                                .cornerRadius(10)
                            
                        }
                        .padding()
                    }
                }
            }
        }
        
    }
    
    func resetGrid() {
        for bubble in self.model.bubbles {
            bubble.isPopped = false
        }
    }
    
    func resetScore() {
        self.model.score = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        ContentView().environmentObject(ContentViewModel())
              .environment(\.colorScheme, .dark)
        }
    }
}
