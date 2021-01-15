 
import SwiftUI
import PDFKit

struct PDFPreviewView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isReady = false
    @State private var pdfURL: URL?
    @State private var isSharing: Bool = false
    
    var form: Form781
    
    var body: some View {
        ZStack{
            if pdfURL != nil{
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            self.isSharing = true
                        } label: {
                            HStack{
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                        }
                        .padding(.trailing)
                        
                        Button {
                            self.printPDF()
                        } label: {
                            HStack{
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
                            .colorMultiply(.pblPrimary)
                    }else{
                        PDFRepView(url:pdfURL!)
                            .padding()
                    }
                       
                    
                }.sheet(isPresented: $isSharing, onDismiss: nil, content: {
                    ActivityViewController(activityItems: [pdfURL!])
                })
                
                
            }else{
                ActivityIndicator(isAnimating: true)
            }
        }.onAppear{
            print("do the stuff")
            form.generatePDF() { result in
                switch result {
                case .success(let url):
                   pdfURL = url
                    isReady = true
                case .failure(let error):
                    print(error.description())
                }
            }
        }
        
    }
    func printPDF(){
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
        if darkMode{
            pdfView.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        }
       
    }
    
}

struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = [.postToWeibo, .postToFlickr, .postToTwitter, .postToVimeo, .postToFacebook, .postToTencentWeibo, .markupAsPDF, .assignToContact, .openInIBooks, .saveToCameraRoll]
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
}
