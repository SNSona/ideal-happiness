//
//  ImageView.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 05.06.22.
//

import SwiftUI
import Kingfisher

extension ImageDataView {
    typealias ViewModel = AnyViewModel<Self.ViewState, Self.ViewInput>
    
    // MARK: - State
    
    struct ViewState {
        var isLoading = false
        var imageData: ImageData?
        var image: UIImage?
    }
    
    // MARK: - Input
    
    enum ViewInput {
        case sendImage(UIImage)
    }
}

struct ImageDataView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading photos...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: 120, height: 120, alignment: .top )
                    .foregroundColor(.white)
                    .font(.title)
            }
            
            ZoomableScrollView {
                KFImage(URL(string: viewModel.state.imageData!.downloadURL)!)
                    .onSuccess { result in
                        viewModel.trigger(.sendImage(result.image))
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                Button(action: {
                    if let data = viewModel.image {
                        UIImageWriteToSavedPhotosAlbum(data, nil, nil, nil)
                    }
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                    Text("Save")
                })
                
                Button(action: {
                    if let data = viewModel.image {
                        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                })
            }
        }
    }
}

struct ImageDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDataView(viewModel: ImageViewModelImpl(image: ImageData.fackData()).toAnyViewModel())
    }
}
