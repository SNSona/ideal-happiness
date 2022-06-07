//
//  ListView.swift
//  GlowingCollage
//
//  Created by Sona Sargsyan on 04.06.22.
//

import SwiftUI
import Kingfisher

extension ListView {
    typealias ViewModel = AnyViewModel<Self.ViewState, Self.ViewInput>
    
    // MARK: - State
    
    struct ViewState {
        var isLoading = Set<LoadingContent>()
        var list = ImageList()
        var imageDataViewModel: ImageDataView.ViewModel?
    }
    
    // MARK: - Input
    
    enum ViewInput {
        case showImage(ImageData)
        case reloadList
    }
    
    // MARK: - Model Date
    
    enum LoadingContent: Hashable {
        case conetent
    }
}

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    
    private var percentage: GLfloat { GLfloat.random(in: 0...1) }
    private var postType: [String] {["iOS", "SwiftUI", "Combine"] }
    
    @ViewBuilder
    private func cellFor(
        item: ImageData
    ) -> some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 150)
                .foregroundStyle(.ultraThinMaterial)
            
            HStack {
                
                KFImage(URL(string: item.downloadURL)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
                
                VStack {
                    
                    Text(item.author)
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack {
                            tags(tags: postType)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        
                        Text("The Happy Programmer")
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                        
                        ProgressView(value: percentage)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.pink))
                            .foregroundColor(Color.red)
                        
                        Text(String(format: "%.0f%%", percentage * 100))
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    }
                }.padding()
            }
            .padding(.leading)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("nkar1")
                    .resizable()
                    .ignoresSafeArea()
                    .overlay(
                        Image("logo")
                    )
                
                if viewModel.isLoading.contains(.conetent) {
                    ProgressView("Loading photos...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 120, height: 120, alignment: .top )
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                List(viewModel.list, id: \.self) { item in
                    
                    cellFor(item: item)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .onAppear {
                            if item == viewModel.list.last {
                                viewModel.trigger(.reloadList)
                            }
                        }
                        .onTapGesture {
                            viewModel.trigger(.showImage(item))
                        }
                }
                .navigation(item: $viewModel.state.imageDataViewModel) {
                    ImageDataView(viewModel: $0)
                }
                .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
            }
            .navigationTitle("Photos 🌸")
            .navigationBarItems(leading: Image("gelato")
                .resizable()
                .aspectRatio(contentMode: .fit)
            )
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.yellow]
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.white.opacity(0.2))
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .navigationViewStyle(.stack)
        .listStyle(GroupedListStyle())
        .navigation(item: $viewModel.state.imageDataViewModel) {
            ImageDataView(viewModel: $0)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModelImpl().toAnyViewModel())
    }
}
