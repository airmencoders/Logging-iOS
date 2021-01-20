//
//  NamespaceWrapper.swift
//  NamespaceWrapper for using matchedGeometryEffect in iOS 13 code
//
//  Created by Emil Pedersen on 16/10/2020.
//
import SwiftUI

@available(iOS 14, *)
struct NamespaceWrapper<Content: View>: View {
    @Namespace var namespace
    
    var content: Content
    
    var body: some View {
        content.environment(\.namespace, namespace)
    }
}

@available(iOS 14, *)
struct NamespaceReader<Content: View, ID: Hashable>: View {
    @Environment(\.namespace) var namespace
    
    var content: Content
    
    var id: ID
    var anchor: UnitPoint = .center
    var isSource: Bool = true
    
    var body: some View {
        content.matchedGeometryEffect(id: id, in: namespace!, anchor: anchor, isSource: isSource)
    }
}

@available(iOS 14, *)
struct NamespaceKey: EnvironmentKey {
    static let defaultValue: Namespace.ID? = nil
}

@available(iOS 14, *)
extension EnvironmentValues {
    var namespace: Namespace.ID? {
        get {
            self[NamespaceKey.self]
        }
        set {
            self[NamespaceKey.self] = newValue
        }
    }
}

extension View {
    func namespaced() -> AnyView {
        if #available(iOS 14, *) {
            return AnyView(NamespaceWrapper(content: self))
        } else {
            return AnyView(self)
        }
    }
    
    func namespacedMatchedGeometryEffect<ID>(id: ID, anchor: UnitPoint = .center, isSource: Bool = true) -> some View where ID : Hashable {
        if #available(iOS 14, *) {
            return AnyView(NamespaceReader(content: self, id: id, anchor: anchor, isSource: isSource))
        } else {
            return AnyView(self)
        }
    }
}
