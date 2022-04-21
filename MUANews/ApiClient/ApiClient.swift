//
//  ApiClient.swift
//  MUANews
//
//  Created by Акылай Бекболсунова on 22.04.2022.
//

import Foundation
import SwiftSoup

class ApiClient {
    
    func getListNews(completionHandler: @escaping ([NewsModel]) -> Void) {
        let url = URLRequest(url: URL(string: "http://alatoo.edu.kg/view/public/news/list.xhtml;jsessionid=rFFgmrnjXop_iCtRcvvdFBIhOcM17jWB35guJ4XN.unknown-host#gsc.tab=0")!)
        
        URLSession.shared.dataTask(with: url) { data, response, erro in
            if let data = data {
                do {
                    completionHandler(try self.parseHtml(data: data))
                } catch {
                    
                }
            }
        }.resume()
    }
    
    private func parseHtml(data: Data) throws -> [NewsModel] {
        let document: Document = try SwiftSoup.parseBodyFragment(String(decoding: data, as: UTF8.self))

        let listNews = try document.body()?.getElementById("container")?.getElementById("wrap-content")?.getElementById("content")?.getElementById("news-list")?.getElementById("j_idt636")?.getElementById("j_idt636_content")?.getElementById("j_idt636_list")?.getAllElements()
        
        var newsModels: [NewsModel] = []
        
        try listNews?.forEach({ item in
            if item.tagName() == "li" {
                let image = try item.getElementsByTag("div")[0].getElementsByTag("img")[0].outerHtml()
                let title = try item.getElementsByTag("div")[2].text()
                let date = try item.getElementsByTag("div")[1].getElementsByTag("p")[0].text()
                let link = try String(item.getAllElements()[0].getElementsByTag("a")[0].getElementsByClass("public-news-item grid_4 clearfix").outerHtml().split(separator: "\"")[1])
                
                newsModels.append(NewsModel(
                    title: title,
                    date: date,
                    image: image,
                    
                    newsLink: link))
            }
        })
        
        return newsModels
    }
}


