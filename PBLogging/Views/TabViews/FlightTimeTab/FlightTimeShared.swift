//
//  FlightTimeConstants.swift
//  Logging
//
//  Created by John Bethancourt on 3/5/21.
//

import SwiftUI

enum FlightTimeConstants {
    static let rowHeight: CGFloat = 40
    static let totalColumnWidth: CGFloat = 55
}

extension View {
    func onTouches(down: @escaping () -> Void, up: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(onBegan: down,  onEnded: up))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let onBegan: () -> Void
    let onEnded: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                    .onChanged { _ in
                                        if !self.tapped {
                                            self.tapped = true
                                            onBegan()
                                        }
                                    }
                                    .onEnded { _ in
                                        self.tapped = false
                                        onEnded()
                                    })
    }
}

struct FadeInText: View {
    var text: String
    @State var opacity: Double = 0
    
    var body: some View {
        Text(text)
            .opacity(opacity)
            .onAppear{
                withAnimation{
                    opacity = 1.0
                }
            }
    }
}

struct FlightTimeTotalsView: View {
    var totals: DisplayRow
    
    var body: some View {
        HStack {
            Group {
                Text("\(totals.primary, specifier: "%1.1f")")
                Text("\(totals.secondary, specifier: "%1.1f")")
                Text("\(totals.instructor, specifier: "%1.1f")")
                Text("\(totals.evaluator, specifier: "%1.1f")")
                Text("\(totals.other, specifier: "%1.1f")")
            }
            .frame(maxWidth: .infinity, alignment: Alignment.center)
            
            Text("\(totals.total, specifier: "%1.1f")")
                .frame(width: FlightTimeConstants.totalColumnWidth, alignment: Alignment.center)
        }
    }
}

struct CrewRowView: View {
    
    @Binding var timeRow: TimeRow
    
    var body: some View {
        HStack {
            Group {
                TextField("", text: $timeRow.primary.text)
                TextField("", text: $timeRow.secondary.text)
                TextField("", text: $timeRow.instructor.text)
                    .disabled(timeRow.instructor.disabled)
                    .opacity(timeRow.instructor.disabled ? 0.0 : 1.0)
                TextField("", text: $timeRow.evaluator.text)
                    .disabled(timeRow.evaluator.disabled)
                    .opacity(timeRow.evaluator.disabled ? 0.0 : 1.0)
                TextField("", text: $timeRow.other.text)
                Text("\(timeRow.total, specifier: "%1.1f")")
                    .frame(width: FlightTimeConstants.totalColumnWidth)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .keyboardType(.decimalPad)
        .multilineTextAlignment(.center)
    }
}

struct CrewRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let crewLine = SampleData.crewLine
        CrewRowView(timeRow: .constant(TimeRow(with: crewLine)))
            .padding()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

struct NumberColumn: View {
    
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
        }
    }
}

struct NameColumnView: View {
    
    var title: String
    var crewLines: [TimeRow]
    var hasGhost: Bool = false
    @State var ghostPressed: Bool = false
    
    var body: some View {
        VStack(spacing:0) {
            Text(title)
                .font(.headline)
                .frame(maxWidth:.infinity)
                .frame(height: FlightTimeConstants.rowHeight)
            Divider()
            
            if hasGhost {
                HStack {
                    Text("Ghost")
                        .frame(maxWidth:.infinity)
                        .opacity(ghostPressed ? 0.5 : 1.0)
                }
                .frame(height: FlightTimeConstants.rowHeight)
                .onTouches(down: {
                    withAnimation { ghostPressed = true }
                }, up: {
                    withAnimation { ghostPressed = false }
                })
                Divider()
            }
            
            ForEach(crewLines, id: \.crewLine) { crew in
                NameCell(crew: crew.crewLine)
                    .frame(height: FlightTimeConstants.rowHeight)
                Divider()
            }
            Text("Totals")
                .frame(maxWidth:.infinity)
                .frame(height: FlightTimeConstants.rowHeight)
        }
        .frame(width:200)
    }
}

struct NameCell: View {
    @ObservedObject var crew: CrewLine
    var body: some View {
        HStack {
            Text(crew.person.lastName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
            Text(crew.flightAuthDutyCode)
                .lineLimit(1)
                .frame(width: 50, alignment: .leading)
        }
    }
}
