//
//  MultipleImagePicker.swift
//  DKH-Store
//
//  Created by Darrien Huntley on 12/16/21.
//


import SwiftUI


struct MultipleImagePicker:UIViewControllerRepresentable {
    @Binding var images: [Identifiable_UIImage]
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = imagePickerCoordinator
    
    var sourceType:UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MultipleImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> MultipleImagePicker.Coordinator {
        return imagePickerCoordinator(images: $images)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MultipleImagePicker>) {}
    
}


//------------------ COORDINATOR
class imagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var images: [Identifiable_UIImage]
    init(images:Binding<[Identifiable_UIImage]>) {
        _images = images
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(
            Identifiable_UIImage(image: uiimage)
            )
        }
    }
}
