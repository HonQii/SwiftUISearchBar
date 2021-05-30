//
//  SearchBar.swift
//  SwiftUISearchBar
//
//  Created by HonQi on 2021/5/30.
//

import SwiftUI


extension View {
    public func embedInNavigationBar(_ searchText: Binding<String>, placeholder: String? = nil, showOnAppear: Bool = true, hideWhenScrolling: Bool = true) -> some View {
        self.modifier(SearchBarModifier(searchBarUpdating: SearchBarModifier.SearchBarUpdating(searchText: searchText),
                                        isShowSearchBarOnAppear: showOnAppear,
                                        hidesSearchBarWhenScrolling: hideWhenScrolling,
                                        placeholder: placeholder))
    }
}


struct SearchBarModifier: ViewModifier {
    let searchBarUpdating: SearchBarUpdating
    let isShowSearchBarOnAppear: Bool
    let hidesSearchBarWhenScrolling: Bool
    let placeholder: String?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerLifeRepresentable(didMoveToParent: { viewController in
                    viewController?.navigationItem.searchController = searchBarUpdating.searchController
                    searchBarUpdating.searchController.searchBar.placeholder = placeholder
                    searchBarUpdating.searchController.searchBar.text = searchBarUpdating.text
                    if isShowSearchBarOnAppear {
                        viewController?.navigationController?.navigationBar.sizeToFit()
                    }
                    viewController?.navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
                }, willMoveToParent: nil)
                    .frame(width: 0, height: 0)
            )
    }
    
    class SearchBarUpdating: NSObject, UISearchResultsUpdating {
        @Binding var text: String
        let searchController: UISearchController = UISearchController(searchResultsController: nil)
        
        init(searchText: Binding<String>) {
            self._text = searchText
            super.init()
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchResultsUpdater = self
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            if let searchBarText = searchController.searchBar.text {
                self.text = searchBarText
            }
        }
    }
}


