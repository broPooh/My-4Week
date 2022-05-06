//
//  MainCollectionViewController.swift
//  My 4Week
//
//  Created by bro on 2022/05/05.
//

import UIKit


// tableView -> CollectionView
// row -> item
class MainCollectionViewController: UIViewController {
    
    //1. CollectionView 아웃렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    
    var mainArray = Array(repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.tag = 100
        mainCollectionView.tag = 200
        

        //3. Delegate 연결
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        //4. XIB 파일 연결
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        
        //UIScreen.main.bounds.width -> 스크린 사이즈 가져오기
        
        let spacing: CGFloat = 20
        
        let width =  UIScreen.main.bounds.width - (spacing * 4)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        //layout.minimumInteritemSpacing = spacing
        //layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        //우리가 생성한 컬렉션뷰 레이아웃으로 설정
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.backgroundColor = .yellow
        
        tagCollectionViewConfig()
    }
    
    func tagCollectionViewConfig() {
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        let tagNibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(tagNibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        
        //셀과 셀 사이의 간격
        tagLayout.minimumInteritemSpacing = tagSpacing
        
        //item 여백 설정 -> android padding
        tagLayout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        tagCollectionView.collectionViewLayout = tagLayout
    }
    
    @objc func heartButtonClicked(selectButton: UIButton) {
        print("\(selectButton.tag) 버튼 클릭")
        
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
        //selectButton.setImage(heartImage(item: mainArray[selectButton.tag]), for: .normal)
        //mainCollectionView.reloadData() //전체 갱신
        mainCollectionView.reloadItems(at: [ IndexPath(item: selectButton.tag, section: 0)]) //하나의 아이템 갱신
    }
    
    func heartImage(item: Bool) -> UIImage {
        return item == true ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
    }
    

    // MARK: - Navigation

}

// 2. CollectionView Protocol
extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 100 {
            return 10
        } else {
            return mainArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            
            cell.tagLabel.text = "\(indexPath.row)"
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 2
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
            
            let item = mainArray[indexPath.item]
            
            let image = item == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            
            cell.mainImageView.backgroundColor = .blue
            //tag에 어떤 셀의 버튼이 눌렸는지를 알수 있게 tag를 달아준다
            //tag에는 idexPath의 item으로 좌표값을 넣어주었음
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    
}
