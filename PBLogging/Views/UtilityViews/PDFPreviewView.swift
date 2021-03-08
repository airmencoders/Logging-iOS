//
//  PDFPreviewView.swift
//  Logging
//

import SwiftUI
import PDFKit

struct PDFPreviewView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isReady = false
    @State private var pdfURL: URL?
    @State private var isSharing = false
    
    //var form: Form781
    var event: Event
    
    var body: some View {
        ZStack {
            if pdfURL != nil {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            self.isSharing = true
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                        }
                        .padding(.trailing)
                        
                        Button {
                            self.printPDF()
                        } label: {
                            HStack {
                                Image(systemName: "printer")
                                Text("Print")
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    if colorScheme == .dark {
                        PDFRepView(url:pdfURL!, darkMode: true)
                            .padding()
                            // Inverts the black and white on the form to give a black background with white text
                            .colorInvert()
                            .colorMultiply(.pblForegroundPrimary)
                            .blur(radius: isReady ? 0.0 : 3.0)
                    } else {
                        PDFRepView(url:pdfURL!)
                            .padding()
                            .blur(radius: isReady ? 0.0 : 3.0)
                    }
                }
                .sheet(isPresented: $isSharing) {
                    ShareView(activityItems: [pdfURL!], callback: afterShare(_:_:_:_:))
                }
            } else {
                ActivityIndicator(isAnimating: true)
            }
        }
        .onAppear {
            event.generatePDFs { result in
                switch result {
                case .success(let url):
                    pdfURL = url
                    withAnimation (Animation.easeInOut(duration: 0.6).delay(0.2)){
                        isReady = true
                    }
                case .failure(let error):
                    print(error.description())
                }
            }
        }
    }
    
    func afterShare(_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void{
        
        if let error = error {
            // TODO: Figure out what kind of errors can happen here and handle appropriately vs this:
            AlertProvider.shared.showAlertWithTitle(title: "Share error", message: "\(error), \(error.localizedDescription). Please screenshot and send to the dev team.")
            return
        }
        if completed {
            if activityType?.rawValue == "com.mattermost.rn.MattermostShare" || activityType == UIActivity.ActivityType.mail {
                
                // TODOL Determine if we still need/want to capture this.
            }
        }
    }
    
    func printPDF() {
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = pdfURL!.lastPathComponent  // force unwrap as function won't be available unless the pdf is already generated correctly
        printInfo.outputType = .grayscale
        
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = true
        printController.printingItem = pdfURL!
        printController.present(animated: true, completionHandler: nil)
    }
}

struct ActivityIndicator: UIViewRepresentable {
    var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct PDFRepView : UIViewRepresentable {
    
    var url: URL
    var darkMode: Bool = true
    
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let pdfView = uiView as! PDFView
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        if darkMode {
            pdfView.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        }
    }
}

struct ShareView: UIViewControllerRepresentable {
    
    let excludedActivityTypes: [UIActivity.ActivityType]? = [.postToWeibo, .postToFlickr, .postToTwitter, .postToVimeo, .postToFacebook, .postToTencentWeibo, .assignToContact, .message, .print, .assignToContact]
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    typealias CallbackType = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    var callback: CallbackType?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.completionWithItemsHandler = callback
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing
    }
}

struct ShareView_Previews: PreviewProvider {
    static let url = URL(fileURLWithPath: Bundle.main.path(forResource: "fillable781v3", ofType: "pdf")!)
    static var previews: some View {
        ShareView(activityItems: [url])
    }
}

struct PDFPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PDFPreviewView(event: SampleData.event)
            .iPadPro9_7(isDark: false)
        PDFPreviewView(event: SampleData.event)
            .iPadPro9_7(isDark: true)
    }
}
