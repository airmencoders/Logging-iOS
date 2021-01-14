//
//  SideView.swift
//  Logging
//
//  Created by Bethany Morris on 1/5/21.
//

import SwiftUI

struct SideView: View {
    
    @State private var isCollapsed: Bool = false
    @State private var prefersPortraitCollapsed = false
    @Binding var currentView: PBLBodyViewID
    
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Form781.date, ascending: true)],
        animation: .default)
    
    private var forms: FetchedResults<Form781>
    
    let orientationChanged = UIDevice.orientationDidChangedPublisher
    
    var body: some View {
        VStack{
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                RegularText(text: "MISSION FORMS", size: 16, color: Color.pblSlate)
                    .padding()
                Spacer()
                ChevronRotateButton(value: $isCollapsed)
                    .padding(.trailing, 14)
            }
            VStack(alignment: .leading) {
                
                SideViewButton(text: "OVERVIEW",     action: {
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
                
                HStack(alignment: .center, content: {
                    RegularText(text: "DAYS", size: 16, color: Color.pblSlate)
                        .padding(.top)
                    Spacer()
                    Button {
                        PersistenceController.newRecordForContext()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.pblSlate)
                            .padding(.top)
                    }
                })
                .padding(.horizontal)
                ScrollView {
                    ForEach(forms) { form in
                        SideViewButton(text: form.date?.string() ?? "No Date", action: {
                            //currentForm = form
                        })
                    }
                }
                // Keep this last to push everything up.
                Spacer()
            }.opacity(isCollapsed ? 0.0 : 1.0) // to fade with animation
            
        }
        .background(Color.pblMistBG)
        //per figma 207
        .frame(width: 207)
        //per figma collapsed size is 40
        .offset(x: isCollapsed ? -167 : 0)
        .padding(.trailing, isCollapsed ? -167 : 0)
        //show sidebar if not shown when rotated to landscape
        //matches behavior of stl NavigationSidebar
        .onReceive(orientationChanged) { _ in
            // we are rotating to landscape
            if UIDevice.current.orientation.isLandscape {
                // Store collapsed state from portrait mode, for restoration
                // if returned to portrait mode.
                // This mimics the behavior of the Apple Navigation side bar
                prefersPortraitCollapsed = isCollapsed
                withAnimation(.smooth()){
                    isCollapsed = false
                }
                // we are rotating to portrait
            }else if UIDevice.current.orientation.isPortrait {
                withAnimation(.smooth()){
                    isCollapsed = prefersPortraitCollapsed
                }
            }
        }
    }
}

struct ChevronRotateButton: View {
    @Binding var value: Bool
    var body: some View {
        Button{
            withAnimation(.smooth()){
                value.toggle()
            }
        } label:{ Image(systemName: "chevron.right") }
        .rotationEffect(Angle(degrees: value ? 0 : 180))
    }
}

struct SideView_Previews: PreviewProvider {
    @State static var showView: PBLBodyViewID = .overview

    static var previews: some View {
        let previewController = PersistenceController.preview

        Group {
            SideView(currentView: $showView)
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .previewLayout(.sizeThatFits )

            SideView(currentView: $showView)
                .environment(\.managedObjectContext, previewController.container.viewContext)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
