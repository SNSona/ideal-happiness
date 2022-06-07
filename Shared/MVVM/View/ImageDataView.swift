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
    }
    
    // MARK: - Input
    
    enum ViewInput { }
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
                        .resizable()
                        .ignoresSafeArea()
                }
        }
    }
}

struct ImageDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDataView(viewModel: ImageViewModelImpl(image: ImageData.fackData()).toAnyViewModel())
    }
}
