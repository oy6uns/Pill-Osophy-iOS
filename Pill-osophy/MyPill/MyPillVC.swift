//
//  MyPillVC.swift
//  Pill-osophy
//
//  Created by saint on 2023/05/30.
//

import UIKit
import SnapKit
import Then

class MyPillVC: UIViewController {
    
    let picVC = PicVC()
    
    private let appIcon = UIImageView().then{
        $0.image = UIImage(named: "appname")
        $0.backgroundColor = .clear
    }
    
    private let pageTitle = UIImageView().then{
        $0.image = UIImage(named: "title")
        $0.backgroundColor = .clear
    }
    
    static var mypillList: [MyPillModel] = [
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알"),
//        MyPillModel(date: "2023-05-30 23:06", detail: "타이레놀 2알, 게보린 1알")
    ]
    
    lazy var myPillListCV : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.contentInset.bottom = 60
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    // MARK: - Constants
    final let imageListLineSpacing: CGFloat = 4.adjustedW

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        registerCVC()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("DismissModalView"),
            object: nil
        )
    }
    
    // MARK: - Functions
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async { [self] in
            
            /// postingView가 dismiss될때 컬렉션뷰를 리로드해줍니다.
            print(MyPillVC.mypillList)
            myPillListCV.reloadData()
            print("reload 성공!")
        }
    }
    
    private func registerCVC() {
        myPillListCV.register(
            MyPillCVC.self, forCellWithReuseIdentifier: MyPillCVC.className)
    }
}

extension MyPillVC{
    private func setLayout() {
        view.backgroundColor = .white
        view.addSubviews([appIcon, pageTitle, myPillListCV])
        
        appIcon.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(157)
            $0.height.equalTo(50)
        }
        
        pageTitle.snp.makeConstraints{
            $0.top.equalTo(appIcon.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(108)
            $0.height.equalTo(29)
        }
        
        myPillListCV.snp.makeConstraints{
            $0.top.equalTo(pageTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyPillVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 71)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return imageListLineSpacing
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailBookVC = DetailViewController()
//        detailBookVC.bookdata = CameBookVC.bookList[indexPath.row]
//        detailBookVC.modalPresentationStyle = .overFullScreen
//        present(detailBookVC, animated: true, completion:nil)
//    }
}

// MARK: - UICollectionViewDataSource
extension MyPillVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyPillVC.mypillList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pillCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPillCVC.className, for: indexPath) as? MyPillCVC else { return UICollectionViewCell() }
        pillCell.dataBind(model: MyPillVC.mypillList[indexPath.row])
        return pillCell
    }
}
