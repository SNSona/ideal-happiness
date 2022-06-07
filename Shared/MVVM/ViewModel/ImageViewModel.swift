//
//  ImageViewModel.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 05.06.22.
//

import Foundation
import Combine


class ImageViewModel: ViewModelBase<ImageDataView.ViewState, ImageDataView.ViewInput> {
    
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let imageSubject = CurrentValueSubject<ImageData?, Never>(nil)
    
    
    init(
        image: ImageData
    ) {
        super.init(state: .init())
        self.imageSubject.send(image)
    }
    
    override var bindings: [AnyCancellable] {
        [
            imageSubject
                .assign(to: \.state.imageData, on: self),
            
            isLoadingSubject
                .assign(to: \.state.isLoading, on: self),
        ]
    }
}

final class ImageViewModelImpl: ImageViewModel {
    
}
