//
//  PicVC.swift
//  Pill-osophy
//
//  Created by saint on 2023/05/30.
//

import UIKit
import SnapKit
import Then
import Photos
import Moya

class PicVC: UIViewController {
    
    // MARK: - Properties
    var pillList: [PillModel] = [
        PillModel(albumImage: "1", title: "아로나민골드", singer: "혼합비타민제", num: 0),
        PillModel(albumImage: "2", title: "게보린", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "3", title: "우루사", singer: "간장질환용제", num: 0),
        PillModel(albumImage: "4", title: "타이레놀", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "5", title: "머시론", singer: "피임제", num: 0),
        PillModel(albumImage: "6", title: "인후신", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "7", title: "아세트아미노펜", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "8", title: "이가탄", singer: "치과구강용약", num: 0),
        PillModel(albumImage: "9", title: "지르텍", singer: "항히스타민제", num: 0),
        PillModel(albumImage: "10", title: "인사돌플러스", singer: "치과구강용약", num: 0),
        PillModel(albumImage: "11", title: "임팩타민", singer: "비타민 B제", num: 0),
        PillModel(albumImage: "12", title: "멜리안", singer: "피임제", num: 0),
        PillModel(albumImage: "13", title: "액티리버모닝", singer: "간장질환용제", num: 0),
        PillModel(albumImage: "14", title: "둘코락스에스", singer: "하제, 완장제", num: 0),
        PillModel(albumImage: "15", title: "판시딜", singer: "단백아미노산제제", num: 0),
        PillModel(albumImage: "16", title: "센시아", singer: "기타의 조직세포의 기능용의약품", num: 0),
        PillModel(albumImage: "17", title: "모드콜에스", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "18", title: "이지엔6이브", singer: "해열.진통.소염제", num: 0),
        PillModel(albumImage: "19", title: "벤포벨", singer: "기타의 비타민제", num: 0),
        PillModel(albumImage: "20", title: "동성정로환", singer: "정장제", num: 0),
        PillModel(albumImage: "21", title: "카베진코와", singer: "건위소화제", num: 0)
    ]
    
    var filterdata: [PillModel] = []
    
    private let closeButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "closeBtn"), for: .normal)
        $0.contentMode = .scaleToFill
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "알약 사진촬영"
        $0.font = .systemFont(ofSize: 16.adjustedW, weight: .semibold)
    }
    
    let picBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.setTitle("앨범에서 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let cameraBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.setTitle("사진 촬영하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let picView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    let breedLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.textColor = .hBlue1
    }
    
    let imagePickerController = UIImagePickerController()
    
    var drugData: ImageResponseDto?
    
    let userRouter = MoyaProvider<UserRouter>(
        plugins: [NetworkLoggerPlugin(verbose: true)]
    )
    
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
    
    private let uploadBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        imagePickerController.delegate = self
        
        /// private Func
        setLayout()
        setPress()
        registerCVC()
        
    }
    
    // MARK: - Function
    private func registerCVC() {
        myPillListCV.register(
            PicCVC.self, forCellWithReuseIdentifier: PicCVC.className)
    }
    
    private func setPress() {
        closeButton.press {
            if self.navigationController == nil{
                self.dismiss(animated: true, completion: nil)
            }
            self.navigationController?.dismiss(animated: true)
        }
        
        picBtn.press {[self] in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
            
            // 서버 통신 후로 수정해주어야 함.
            uploadBtn.isUserInteractionEnabled = true
            uploadBtn.backgroundColor = .black
            uploadBtn.setTitleColor(.white, for: .normal)
        }
        
        cameraBtn.press { [self] in
            //            switch PHPhotoLibrary.authorizationStatus() {
            //            case .denied:
            //                self.settingAlert()
            //            case .restricted:
            //                break
            //            case .authorized:
            //                self.imagePickerController.sourceType = .camera
            //                self.present(self.imagePickerController, animated: true, completion: nil)
            //            case .notDetermined:
            //                PHPhotoLibrary.requestAuthorization({ state in
            //                    if state == .authorized {
            //                        self.imagePickerController.sourceType = .camera
            //                        self.present(self.imagePickerController, animated: true, completion: nil)
            //                    } else {
            //                        self.dismiss(animated: true, completion: nil)
            //                    }
            //                })
            //            default:
            //                break
            //            }
            let pickerController = UIImagePickerController() // must be used from main thread only
            pickerController.sourceType = .camera
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            // 만약 비디오가 필요한 경우,
            //      imagePicker.mediaTypes = ["public.movie"]
            //      imagePicker.videoQuality = .typeHigh
            pickerController.delegate = self
            self.present(pickerController, animated: true)
            // 서버 통신 후로 수정해주어야 함.
            uploadBtn.isUserInteractionEnabled = true
            uploadBtn.backgroundColor = .black
            uploadBtn.setTitleColor(.white, for: .normal)
        }
        
        uploadBtn.press {
            let currentTime = Date()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let formattedDate = formatter.string(from: currentTime)
            
            var infoData : String = ""
            
            for pill in self.filterdata {
                if infoData.isEmpty {
                    infoData = "\(pill.title) \(pill.num)알"
                } else {
                    infoData += ", \(pill.title) \(pill.num)알"
                }
            }
            
            MyPillVC.mypillList.insert(MyPillModel(date: formattedDate, detail: infoData, image: self.picView.image!), at: 0)
            
            NotificationCenter.default.post(name: NSNotification.Name("DismissModalView"), object: nil, userInfo: nil)
            
            print(formattedDate)
            if self.navigationController == nil{
                self.dismiss(animated: true, completion: nil)
            }
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    private func settingAlert(){
        if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
            let alert = UIAlertController(title: "설정", message: "\(appName)이(가) 카메라 접근 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .default)
            let confirmAction = UIAlertAction(title: "확인", style: .default) {
                (action) in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            
        }
    }
    
    // MARK: - Server Helpers
    func sendImage(param: ImageRequestDto) {
        userRouter.request(.drugIdentification(param: param)) { response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        self.drugData = try result.map(ImageResponseDto.self)
                        if let result = self.drugData{
                            //                            print(result.drug)
                            self.filterdata = []
                            for pill in result.drug{
                                self.pillList[pill[0] - 1].num = pill[1]
                                self.filterdata.append(self.pillList[pill[0] - 1])
                            }
                            print(self.filterdata)
                            self.myPillListCV.reloadData()
                        }
                    }
                    catch(let error) {
                        print(error.localizedDescription)
                    }
                }
                if status >= 400 {
                    print("error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configBreed(breed: String) {
        breedLabel.text = "This dog's breed is a \(breed)!"
    }
}

extension PicVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picView.image = image
        }
        guard let image = picView.image else { return }
        let data = image.jpegData(compressionQuality: 1.0)
        if let data = data{
            let param = ImageRequestDto(image: data)
            sendImage(param: param)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Layout
extension PicVC{
    private func setLayout(){
        view.addSubViews([closeButton, titleLabel, picBtn, cameraBtn, picView, myPillListCV, uploadBtn])
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(13.adjustedH)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjustedW)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        picBtn.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(40.adjustedW)
            $0.width.equalTo(120.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        cameraBtn.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-40.adjustedW)
            $0.width.equalTo(120.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        picView.snp.makeConstraints{
            $0.top.equalTo(picBtn.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300.adjustedW)
            $0.height.equalTo(300.adjustedW)
        }
        
        myPillListCV.snp.makeConstraints{
            $0.top.equalTo(picView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-110)
        }
        
        uploadBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(210.adjustedW)
            $0.height.equalTo(46.adjustedH)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PicVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 71)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let detailBookVC = DetailViewController()
    //        detailBookVC.bookdata = CameBookVC.bookList[indexPath.row]
    //        detailBookVC.modalPresentationStyle = .overFullScreen
    //        present(detailBookVC, animated: true, completion:nil)
    //    }
}

// MARK: - UICollectionViewDataSource
extension PicVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pillCell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCVC.className, for: indexPath) as? PicCVC else { return UICollectionViewCell() }
        pillCell.dataBind(model: filterdata[indexPath.row])
        return pillCell
    }
}
