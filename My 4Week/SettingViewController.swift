//
//  SettingViewController.swift
//  My 4Week
//
//  Created by bro on 2022/05/05.
//

import UIKit

//CaseIterable : 열거형을 배열처럼 순회할 수 있는 옵션이 들어간 프로토콜이다.
//배열에서 index를 통해서 값을 가지고 올수 있는 것처럼 enum에도 사용이 가능하다.
enum SettingSection: Int, CaseIterable{
    case authorization
    case onlineShop
    case question
    
    var description: String {
        switch self {
        case .authorization:
            return "알림 설정"
        case .onlineShop:
            return "온라인 스토어"
        case .question:
            return "Q&A"
        }
    }
}


class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingList = [
        ["위치 알림 설정", "카메라 알림 설정"],
        ["교보 문고", "영풍 문고", "반디앤루니스"],
        ["앱스토어 리뷰 작성하기", "문의하기"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        let nibName = UINib(nibName: DefaultTableViewCell.identifier, bundle: nil)
        
        settingTableView.register(nibName, forCellReuseIdentifier: DefaultTableViewCell.identifier)
    }
    
    // MARK: - Navigation

}


// MARK: - SettingViewTableView Setting
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //enum 클래스에서 CaseIterable의 프로토콜을 추가했기 때문에 사용이 가능한 함수.
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        
        cell.iconImageView.backgroundColor = .blue
        cell.titleLabel.text = settingList[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingSection.allCases[section].description
    }
    
    
}
