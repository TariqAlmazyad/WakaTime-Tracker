//
//  ListPagination.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/24/20.
//

import SwiftUI
//
//public struct ListPagination<Item: Identifiable, Content: View>: View {
//    
//    
//    private var items: [Item]
//    var content: (_ item: Item) -> Content
//    var pagination: ((() -> Void)?) -> Void
//    @State var isLoading = false
//    private var offset: Int
//    public init (items: [Item], offset: Int = 5,
//                 pagination: @escaping (_ completion: (() -> Void)?) -> Void,
//                 @ViewBuilder content: @escaping (_ item: Item) -> Content) {
//        self.items =  items
//        self.content = content
//        self.pagination = pagination
//        self.offset = offset
//    }
//    
//    private func isLastItem(index: Int) -> Bool {
//      index == (items.count - 1)
//    }
//
//    private func isOffsetReached(at index: Int) -> Bool {
//      index == (items.count - offset)
//    }
//
//    private func itemAppears(at index: Int) {
//      if isOffsetReached(at: index) {
//        isLoading = true
//
//        pagination {
//          self.isLoading = false
//        }
//      }
//    }
//    public var body: some View {
//      List {
//        //1.
//        ForEach(items.indices, id: \.self) { index in
//          VStack {
//            //2.
//            self.content(self.items[index])
//
//            //3.
//            if self.isLoading && self.isLastItem(index: index) {
//              HStack(alignment: .center) {
//                //4.
//                SpinnerView(isAnimating: self.$isLoading, style: .medium)
//              }
//            }
//          }.onAppear {
//            //5.
//            self.itemAppears(at: index)
//          }
//        }
//      }
//    }
//}
