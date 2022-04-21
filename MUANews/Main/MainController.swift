//
//  ViewController.swift
//  MUANews
//
//  Created by Акылай Бекболсунова on 22.04.2022.
//

import UIKit

class MainController: UIViewController {

    private lazy var newsListTable: UITableView = {
        let view = UITableView()
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private var newsModels: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MUA News"
        
        view.addSubview(newsListTable)
        newsListTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
        }
        
        ApiClient().getListNews() { models in
            self.newsModels = models
            
            DispatchQueue.main.async {
                self.newsListTable.reloadData()
            }
        }
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = newsModels[indexPath.row]
        
        navigationController?.pushViewController(DetailsController.newInstanse(model: model), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell()
        let model = newsModels[indexPath.row]
        
        cell.fill(model: model)
        
        return cell
    }
}

