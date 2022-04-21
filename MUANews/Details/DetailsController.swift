//
//  DetailsController.swift
//  MUANews
//
//  Created by Акылай Бекболсунова on 22.04.2022.
//

import Foundation
import UIKit
import WebKit

class DetailsController: UIViewController {
    
    private var link: String = String()
    
    static func newInstanse(model: NewsModel) -> DetailsController {
        let controller = DetailsController()
        controller.link = model.newsLink
        controller.title = model.title
        return controller
    }
    
    private lazy var webView: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
                
        let url = URL(string: "http://alatoo.edu.kg\(link)")
        
        if let url = url {
            webView.load(URLRequest(url: url))
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
