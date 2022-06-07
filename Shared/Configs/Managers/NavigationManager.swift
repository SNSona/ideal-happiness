import SwiftUI

extension View {
    
    func navigation<Item, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: (Item) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in if !value { item.wrappedValue = nil } }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }
    
    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(
                destination: isActive.wrappedValue ? destination() : nil,
                isActive: isActive,
                label: { EmptyView() }
            )
        )
    }
    
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder transform: (Self) -> Transform
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<Transform: View, Fallback: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder transform: (Self) -> Transform,
        @ViewBuilder else fallbackTransform: (Self) -> Fallback
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            fallbackTransform(self)
        }
    }
    
    @ViewBuilder
    func `if`<Transform: View, T> (
        `let` optional: T?,
        @ViewBuilder transform: (Self, T) -> Transform
    ) -> some View {
        if let optional = optional {
            transform(self, optional)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<Transform: View, Fallback: View, T> (
        `let` optional: T?,
        @ViewBuilder transform: (Self, T) -> Transform,
        @ViewBuilder else fallbackTransform: (Self) -> Fallback
    ) -> some View {
        if let optional = optional {
            transform(self, optional)
        } else {
            fallbackTransform(self)
        }
    }
    
    @ViewBuilder
    func isHidden(
        _ hidden: Bool,
        removeWhenHidden: Bool = true
    ) -> some View {
        if !hidden {
            self
        } else if !removeWhenHidden {
            self.hidden()
        }
    }
    
    func readSize(
        onChange: @escaping (CGSize) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(
        value: inout CGSize,
        nextValue: () -> CGSize
    ) {}
}
