//
//  SideView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct SideView: View {
    @State var isCollapsed: Bool = false
    @Binding var currentView: PBLBodyViewID
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date, ascending: true)],
        animation: .default)
    
    private var forms: FetchedResults<Form781>
    private let collapsedWidth: CGFloat = 40.0
    private let expandedWidth: CGFloat = 200.0

    var body: some View {
        ZStack {
            Color.pblMistBG
            
            VStack(alignment: .leading) {
                HStack(alignment: .center, content: {
                    BoldText(text: "MISSION FORMS", size: 16, color: Color.pblSlate)
                        .padding()
                        .lineLimit(1)
                    Spacer()
                    ChevronButton()
                        .rotationEffect(.degrees(isCollapsed ? 0 : -180))
                        .padding(isCollapsed ? .leading : .trailing)
                })
                Group{
                    SideViewButton(text: "OVERVIEW", action: {
                        currentView = .overview
                    })
                    SideViewButton(text: "MISSION DATA", action: {
                        currentView = .missionData
                    })
                    SideViewButton(text: "AIRCREW LIST", action: {
                        currentView = .aircrewList
                    })
                    SideViewButton(text: "AIRCREW DATA", action: {
                        currentView = .aircrewData
                    })
                    .padding(.bottom)
                    
                    BoldText(text: "DAYS", size: 16, color: Color.pblSlate)
                        .padding(.leading)
                    ForEach(forms) { form in
                        SideViewButton(text: form.date?.string() ?? "No Date", action: {
                            // Probably need to stash the UUID somewhere
                            // and use it to set the current Form
                        })
                    }
                }.opacity(isCollapsed ? 0.0 : 1.0)
                
                Spacer()
            }
            
        }
        .frame(width: expandedWidth)
        .offset(x: isCollapsed ? -100 : 0)
        .frame(width: isCollapsed ? collapsedWidth : expandedWidth)
        
    }
    
    fileprivate func ChevronButton() -> Button<Image> {
        return Button(action:{
            withAnimation {
                self.isCollapsed.toggle()
            }
        }){
            Image(systemName: "chevron.right")
        }
        
    }
}

struct SideView_Previews: PreviewProvider {
    @State static var showView: PBLBodyViewID = .overview
    
    static var previews: some View {
        let previewController = PersistenceController.preview
        
        Group {
            SideView(isCollapsed: false, currentView: $showView)
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .previewLayout(.sizeThatFits )
            
            SideView(isCollapsed: false, currentView: $showView)
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
