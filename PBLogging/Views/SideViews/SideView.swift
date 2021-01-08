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

    var body: some View {
        ZStack {
            Color.pblMistBG
            if isCollapsed {
                VStack(alignment: .leading) {
                    ChevronButton()
                        .padding()
                    Spacer()
                }
            } else {
                VStack(alignment: .leading) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        BoldText(text: "MISSION FORMS", size: 16, color: Color.pblSlate)
                            .padding()
                        ChevronButton()
                    }
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
                        .padding()
                    ScrollView {
                        ForEach(forms) { form in
                            SideViewButton(text: form.date?.string() ?? "No Date", action: {
                                // Probably need to stash the UUID somewhere
                                // and use it to set the current Form
                            })
                        }
                    }
                    // Keep this last to push everything up.
                    Spacer()
                }
            }
        }
        .frame(width: isCollapsed ? 40 : 200)
        .clipped()
    }

    fileprivate func ChevronButton() -> Button<Image> {
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
