//
//  SideView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct SideView: View {
    @State var isCollapsed: Bool = false
    
    var body: some View {
        ZStack {
            Color.pblMistBG
            if isCollapsed {
                VStack(alignment: .leading) {
                    ShevronButton()
                    .padding()
                    Spacer()
                }
            } else {
                VStack(alignment: .leading) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        BoldText(text: "MISSION FORMS", size: 16, color: Color("slate"))
                            .padding()
                        ShevronButton()
                    }
                    SideViewButton(text: "OVERVIEW")
                    SideViewButton(text: "MISSION DATA")
                    SideViewButton(text: "AIRCREW LIST")
                    SideViewButton(text: "AIRCREW DATA")
                    Spacer()
                    BoldText(text: "DAYS", size: 16, color: Color("slate"))
                        .padding()
                    Spacer()
                }
            }
        }
        .frame(width: isCollapsed ? 40 : 200)
        .clipped()
    }

    fileprivate func ShevronButton() -> Button<Image> {
        return Button(action:{
            withAnimation {
                self.isCollapsed.toggle()
            }
        }){
            Image(systemName:self.isCollapsed ? "chevron.right"
                                              : "chevron.left")
        }
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SideView()
                .previewLayout(.sizeThatFits )
            SideView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
