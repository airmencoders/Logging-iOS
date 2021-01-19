//
//  AircrewCard.swift
//  Logging
//
//  Created by Pete Misik on 1/14/21.
//

import SwiftUI

struct AircrewCard: View {
    
    var member: AircrewData
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.pblBackground)
                .cornerRadius(10.0)
                .frame(width: 700, height: 100, alignment: .center)
                //.shadow(color: Color("primary"), radius: 5, x: 5, y: 5)
                .shadow(color: Color("primary").opacity(0.33), radius: 5, x: 1, y: 2)
                .padding()
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Image(systemName: "person")
                        .padding(.leading, 10)
                    Text(member.flyingOrganization)
                    Spacer()
                    Text(member.lastName)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 1)
                    Spacer()
                    Text(member.ssanLast4)
                }
                .frame(width:600)
                HStack(spacing: 5) {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 20)
                }
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                        .padding(.leading, 10)
                    Text("Primary")
                    Text(String(format: "%.1f", member.ftPrimary))
                        .padding(.leading, 10)
                    Spacer()
                    Image(systemName: "clock")
                        .padding(.leading, 10)
                    Text("Secondary")
                    Text(String(format: "%.1f", member.ftSecondary))
                }
                .frame(width: 600)
            }
            .frame(width: 700, height: 50)
            .foregroundColor(.pblPrimary)
        }
    }
}

struct AircrewCard_Previews: PreviewProvider {
    
    static let previewController = PersistenceController.preview
    
    static let data: AircrewData = {
        let data = AircrewData(context: previewController.container.viewContext)
        data.flyingOrganization = "0016AS"
        data.lastName = "Johnson"
        data.ssanLast4 = "1234"
        data.ftPrimary = 1.0
        data.ftSecondary = 2.0
        return data
    }()
    
    static var previews: some View {
        AircrewCard(member: data)
            .previewLayout(.sizeThatFits)
        AircrewCard(member: data)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
