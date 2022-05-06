//
//  WebViewController.swift
//  My 4Week
//
//  Created by bro on 2022/05/06.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

    }
    


}


extension WebViewController: UISearchBarDelegate {
    
    //서치바에서 검색 리턴키 클릭시 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let url = URL(string: searchBar.text ?? "") else {
            print("Error")
            return
        }
        
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
