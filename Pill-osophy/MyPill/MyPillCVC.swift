//
//  ClothCVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/26.
//

import UIKit
import SnapKit
import Moya
import Then

class MyPillCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let pillIcon = UIImageView().then{
        $0.image = UIImage(named: "💊")
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .systemGray2
    }
    
    private let detailLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        cellShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPillCVC{
    
    // MARK: - Layout Helpers
    private func setLayout() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.addSubviews([pillIcon, titleLabel, detailLabel])
        
        pillIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.adjustedW)
            $0.leading.equalTo(pillIcon.snp.trailing).offset(14.adjustedW)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7.adjustedW)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
    }
    
    func cellShape() {
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.masksToBounds = false
    }
    
    func dataBind(model: MyPillModel) {
        titleLabel.text = model.date
        detailLabel.text = model.detail
        pillIcon.image = model.image
    }
}
