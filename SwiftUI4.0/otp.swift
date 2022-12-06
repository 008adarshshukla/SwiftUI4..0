//
//  otp.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 05/12/22.
//

//
//  EnterOTP.swift
//  Vasukam
//
//  Created by Adarsh Shukla on 05/12/22.
//

import SwiftUI

struct EnterOTP: View {
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        upperView()
                        Spacer()
                        lowerView()
                    }
                    .padding(.horizontal, 25)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image(systemName: "chevron.left")
                                .font(.custom("Poppins-Bold", size: 25))
                        }
                    }
                    .frame(minHeight: geometry.size.height)
                }
                .scrollDisabled(true)
                .frame(width: geometry.size.width)
            }
        }
    }
    
    @ViewBuilder
    private func upperView() -> some View {
        VStack {
            HStack {
                Text("Enter OTP")
                    .font(.custom("Poppins-Bold", size: 30))
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 11)
            
            HStack {
                Text("Sorry, but we only allow authentic users")
                    .font(.custom("Poppins-Medium", size: 18))
                Spacer()
            }
            .padding(.bottom, 100)
            
            OTOHolderView()
        }
    }
    
    @ViewBuilder
    private func lowerView() -> some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 40)
                .frame(height: 81)
                .overlay {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 18))
                }
                .shadow(radius: 5, y: 5)
        }
    }
}

struct EnterOTP_Previews: PreviewProvider {
    static var previews: some View {
        EnterOTP()
    }
}

struct OTOHolderView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var isFocused = false
    
    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                HStack (spacing: spaceBetweenBoxes){
                    
                    otpText(text: viewModel.otp1)
                    otpText(text: viewModel.otp2)
                    otpText(text: viewModel.otp3)
                    otpText(text: viewModel.otp4)
                    otpText(text: viewModel.otp5)
                    otpText(text: viewModel.otp6)
                }
                
                
                TextField("", text: $viewModel.otpField)
                    .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                    .disabled(viewModel.isTextFieldDisabled)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .background(Color.clear)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    private func otpText(text: String) -> some View {
        
        return Circle()
            .foregroundColor(Color.blue)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.red)
            }
            .overlay(alignment: .center) {
                Text(text)
                    .font(.custom("Poppins-Medium", size: 21))
            }
            .frame(width: 55, height: 55)
    }
}

class ViewModel: ObservableObject {
    
    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    var otp1: String {
        guard otpField.count >= 1 else {
            return ""
        }
        return String(Array(otpField)[0])
    }
    var otp2: String {
        guard otpField.count >= 2 else {
            return ""
        }
        return String(Array(otpField)[1])
    }
    var otp3: String {
        guard otpField.count >= 3 else {
            return ""
        }
        return String(Array(otpField)[2])
    }
    var otp4: String {
        guard otpField.count >= 4 else {
            return ""
        }
        return String(Array(otpField)[3])
    }
    
    var otp5: String {
        guard otpField.count >= 5 else {
            return ""
        }
        return String(Array(otpField)[4])
    }
    
    var otp6: String {
        guard otpField.count >= 6 else {
            return ""
        }
        return String(Array(otpField)[5])
    }
    
    @Published var borderColor: Color = .black
    @Published var isTextFieldDisabled = false
    var successCompletionHandler: (()->())?
    
    @Published var showResendText = false
    
}

