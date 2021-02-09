//
//  LoginPage.swift
//  PBLAuthBridge
//
//  Created by Pete Misik on 2/5/21.
//

import SwiftUI

struct LoginPage: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ViewModel()
    @State var showLoader = false
    @State var message = ""
    @State var webTitle = ""

    var webViewNavigationBar: some View {
        VStack(spacing: 0) {
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            HStack {
                Spacer()
                Button(
                    action: {
                        self.viewModel.webViewNavigationPublisher.send(.backward)
                    }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                Group {
                    Spacer()
                    Divider()
                    Spacer()
                }
                Button(action: {
                    self.viewModel.webViewNavigationPublisher.send(.forward)
                }){
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                Group {
                    Spacer()
                    Divider()
                    Spacer()
                }
                Button(action: {
                    self.viewModel.webViewNavigationPublisher.send(.reload)
                }){
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                Spacer()
            } .frame(height: 45)
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
//                HStack {
//                    TextField("Write Message", text: $message).textFieldStyle(RoundedBorderTextFieldStyle())
//                    Button(action: {
//                        self.viewModel.valuePublisher.send(self.message)
//                    }) {
//                        Text("Send")
//                            .padding(.trailing, 10)
//                            .padding(.leading, 10)
//                            .padding(.top, 4)
//                            .padding(.bottom, 4)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 4, style: .circular)
//                                    .stroke(Color.gray, lineWidth: 0.5)
//                            )
//                    }
//                }
//                .padding()
                
                
//                Text(webTitle).font(.title).onReceive(self.viewModel.showWebTitle.receive(on: RunLoop.main)) { value in
//                    self.webTitle = value
//                }
                WebView(urlType: .publicUrl, viewModel: viewModel).overlay (
                    RoundedRectangle(cornerRadius: 4, style: .circular)
                        .stroke(Color.gray, lineWidth: 0.5)
                ).padding(.leading, 20).padding(.trailing, 20)
                                
                webViewNavigationBar
            }
            .background(Color.black)
            .onReceive(self.viewModel.showLoader.receive(on: RunLoop.main)) { value in
                
                self.showLoader = value
            }
                            
            // A simple loader that is shown when WebView is loading any page and hides when loading is finished.
            if showLoader {
                Loader()
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
