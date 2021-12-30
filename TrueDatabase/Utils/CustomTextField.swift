//
//  CustomTextField.swift
//  AppleAndFirebaseSignin
//
//  Created by Darrien Huntley on 6/10/21.
//

import SwiftUI

// (tip) allow for custom color in tect field
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName : String
    let color : Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(color).opacity(0.25)
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(text.isEmpty ? color.opacity(0.25) : color)
                
                TextField("", text: $text)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder:  Text(""), imageName: "envolope", color: .black)
            .frame(height: 300)
            .background(Color.green)
   
            
    }
}
