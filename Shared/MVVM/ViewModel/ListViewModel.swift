//
//  ListViewModel.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 04.06.22.
//

import Foundation
import Combine

extension String {
    static let notImplemented = "Not Implemented!"
}

extension String: LocalizedError {
    public var errorDescription: String? { self }
}

// MARK: - ViewModelBase

class ListViewModel: ViewModelBase<ListView.ViewState, ListView.ViewInput> {
    typealias LoadingContent = ListView.LoadingContent
    
    fileprivate var isLoading: Set<LoadingContent> {
        get { isLoadingSubject.value }
        set { isLoadingSubject.send(newValue) }
    }
    
    private let isLoadingSubject = CurrentValueSubject<Set<LoadingContent>, Never>([])
    private let listSubject = CurrentValueSubject<ImageList, Never>([])
    
    func createImageViewModel(_ imageData: ImageData) -> ImageDataView.ViewModel? { fatalError(.notImplemented) }
    
    var listService: ListService { fatalError(.notImplemented) }
    
    init() {
        super.init(state: .init())
        loadList()
    }
    
    override var bindings: [AnyCancellable] {
        [
            listSubject
                .removeDuplicates()
                .assign(to: \.state.list, on:  self),
            
            isLoadingSubject
                .assign(to: \.state.isLoading, on: self),
        ]
    }
    
    override func trigger(
        _ input: ListView.ViewInput
    ) {
        switch input {
            
        case let .showImage(image):
            state.imageDataViewModel =  createImageViewModel(image)
            
        case .reloadList:
            loadList()
        }
    }
    
    private func loadList() {
        guard  !isLoading.contains(.conetent) else { return }
        
        listService.loadImages()
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.isLoading.insert(.conetent) },
                receiveCompletion: { [weak self] _ in self?.isLoading.remove(.conetent) }
            )
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print("Error ocuured \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] list in
                self?.listService.request.perPage += 1
                self?.state.list += list
            })
            .store(in: &cancelables)
    }
}

final class ListViewModelImpl: ListViewModel {
    
    override var listService: ListService{
        ListServiceImpl.shared
    }
    
    override func createImageViewModel(_ imageData: ImageData) -> ImageDataView.ViewModel? {
        ImageViewModelImpl(image: imageData).toAnyViewModel()
    }
}
