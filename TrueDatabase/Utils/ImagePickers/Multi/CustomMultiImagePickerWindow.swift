//
//  CustomMultiImagePickerWindow.swift
//  DKH-Store
//
//  Created by Darrien Huntley on 12/16/21.
//


import SwiftUI

struct CustomMultiImagePickerWindow: View {
    
    @Binding var showSheet: Bool
    @Binding var showImagePicker : Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var images:[Identifiable_UIImage]
    
    var title : String
    var body: some View {
        VStack {
            ZStack{
                
                // Button
                HStack(spacing:0) {
                    if images.count > 0 {
                        ScrollView(.horizontal){
                            HStack(spacing:0){
                                ForEach(self.images, id: \.id){i in
                                    Image(uiImage: i.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.size.width, height: 300)
                                    
                                }
                            }.background(Color.black)
                        }.background(Color.black)
                        
                    } else {
                        Button(action: {
                            self.showSheet.toggle()
                        }) {
                            
                            Image("defaultImageHolder")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .padding(50)
                                .frame(width: 150, height: 150)
                                .background(Color.init(red: 1, green: 1, blue: 1))
                        }
                        
                    }
                }
                
                
                VStack{
                    HStack{
                        Text(title)
                            .font(.title3)
                            .bold()
                            .padding()
                        
                        Spacer()
                        Button(action: {
                            self.showSheet.toggle()
                        }) {
                            ZStack{
                                Image(systemName: "camera.circle")
                                    .foregroundColor(.black)
                                    .padding()
                                Image(systemName: "camera.circle.fill")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .font(.system(size:30))
                            .shadow(radius: 4)
                            .opacity(0.7)
                            .padding()
                        }.actionSheet(isPresented: $showSheet){
                            ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
                                .default(Text("Camera"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .camera
                                }),
                                .default(Text("Photo Library"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .savedPhotosAlbum
                                }),
                                .cancel()
                                
                            ])
                        }
                    }
                    Spacer()
                }.frame(height:300)
            }.sheet(isPresented: $showImagePicker){
                VStack(spacing:0){
                    // (fix) add condition to check if to allow 1 image of 1+
                    if self.images.count > 0 {
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(self.images, id: \.id){i in
                                    Image(uiImage:i.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height:200)
                                        .shadow(radius:3)
                                }
                                
                            }.padding()
                        }
                        .frame(height:240)
                        .background(Color.white)
                    } else {
                        HStack{
                            Spacer()
                            Text("Please select an image from below")
                            Spacer()
                        }.frame(height:240)
                        .background(Color.white)
                    }
                    HStack{
                        Button(action: {self.showImagePicker.toggle()}){
                            Text("DONE - \(self.images.count) IMAGES")
                                .padding()
                                .font(.system(size:12, weight:.bold))
                                .foregroundColor(.white)
                                .frame(height:24)
                                .background(Color.green)
                                .cornerRadius(12)
                            
                            
                        }
                    }
                    .frame(height:57).frame(maxWidth: .infinity).background(Color.white)
                    .zIndex(1)
                    
                    MultipleImagePicker(images: self.$images, sourceType: self.sourceType).offset(y: -57)
                }
            }
        }
    }
}

struct CustomImagePickerWindow_Previews: PreviewProvider {
    static var previews: some View {
        CustomMultiImagePickerWindow(showSheet: .constant(false), showImagePicker: .constant(false), sourceType:.constant(.camera), images: .constant([]), title: "yooo")
    }
}
