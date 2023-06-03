//
//  PicCVC.swift
//  Pill-osophy
//
//  Created by saint on 2023/05/31.
//

import UIKit
import SnapKit
import Then

class PicCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let pillIcon = UIImageView().then{
        $0.image = UIImage(named: "💊")
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
    }
    
    private let detailLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .systemGray2
    }
    
    private let numLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
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

extension PicCVC{
    
    // MARK: - Layout Helpers
    private func setLayout() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.addSubviews([pillIcon, titleLabel, detailLabel, numLabel])
        
        pillIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(58)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.adjustedW)
            $0.leading.equalTo(pillIcon.snp.trailing).offset(16.adjustedW)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        numLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func cellShape() {
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.masksToBounds = false
    }
    
    func dataBind(model: PillModel) {
        pillIcon.image = UIImage(named: model.albumImage)
        titleLabel.text = model.title
        detailLabel.text = model.singer
        numLabel.text = "x\(model.num)"
    }
}
