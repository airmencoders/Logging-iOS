//
//  ScrollDemo.swift
//  scrolling
//
//  Created by Pete Misik on 2/3/21.
//

import SwiftUI

struct ScrollDemo: View {
    
    private struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
    
    @State var yOffset: CGFloat = 0
    @State var xOffset: CGFloat = 0
    private var numberOfPersonnel = 10
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack (spacing: 0) {
                    // Header bar
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 50) {
                            ForEach(0..<numberOfPersonnel) {
                                CellLabel(text: "Person \($0)", color: Color.black, alignment: "center")
                            }
                        }
                    }
                    
                    .content.offset(x: xOffset)
                    .frame(width: 1000, height: 50)
                    .background(Color.gray)
                    
                   
                    HStack(spacing: 0) {
                        ScrollView(.vertical){
                            VStack {
                                EventID()
                            }
                        }
                        .content.offset(y: yOffset)
                        .frame(width: 200, height: 500)
                        
                        ScrollView(.vertical){
                            VStack {
                                EventTitles()
                            }
                        }
                        .content.offset(y: yOffset)
                        .frame(width: 200, height: 500)
                        
                        ScrollView([.horizontal, .vertical]){
                            VStack {
                                Color.blue.frame(width: 2, height: 2)
                                .background(
                                    GeometryReader {
                                        geometry in
                                        Color.clear
                                            .preference(key: ScrollOffsetPreferenceKey.self,
                                                        value: geometry.frame(in: .named("scrollView")).origin
                                            )
                                    }
                                )
                                HStack(spacing: 10){
                                    ForEach(0..<numberOfPersonnel) { _ in
                                        StackBuilder()
                                    }
                                }
                            }
                        }
                        .coordinateSpace(name: "scrollView")
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
                        }
                    }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                Color.white
                    .frame(width:400,height: 80)
//                    .ignoresSafeArea()
//                    .shadow(color: .white, radius: 30, x: 10, y: -10)
                    Text("Training Events")
                        .font(.headline)
                        .frame(width: 400, height: 50, alignment: .leading)
                }
            }
        }
    
    func offsetChanged(point: CGPoint) {
        yOffset = point.y - 53
        xOffset = point.x - 250
        print(point)
    }
}

struct ScrollDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollDemo()
    }
}
