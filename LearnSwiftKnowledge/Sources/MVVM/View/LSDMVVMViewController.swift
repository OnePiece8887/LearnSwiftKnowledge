//
//  LSDMVVMViewController.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/26.
//

import UIKit
import SnapKit
import LSDObjcSugar
import SwifterSwift
import Combine

class LSDMVVMViewController: LSDBaseViewController {
     
    private let viewModel = BookNoteViewModel(dataService: ProductionDataService())
    
    private var cancellables = Set<AnyCancellable>()
    
    var textLabel: UILabel?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.lsd_button(withTitle: "初始化数据", fontSize: 18, textColor: .white, backgroundColor: .blue, imageName: nil, backImageName: nil, highlightSuffix: nil)!
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(30)
            make.centerX.equalTo(view)
        }
        
        let addbtn = UIButton.lsd_button(withTitle: "添加数据", fontSize: 18, textColor: .white, backgroundColor: .blue, imageName: nil, backImageName: nil, highlightSuffix: nil)!
        addbtn.addTarget(self, action: #selector(addbtnClick), for: .touchUpInside)
        view.addSubview(addbtn)
        addbtn.snp.makeConstraints { make in
            make.top.equalTo(btn.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        self.textLabel = textLabel
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(addbtn.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
        }
        //        订阅
        viewModel.bookNoteModelsPublisher.sink { [weak self] bookNoteModels in
            self?.updateUI(bookNoteModels: bookNoteModels)
        }
        .store(in: &cancellables)
          
        
        viewModel.loadDataFromCoreData()
        
    }
    
    @objc func btnClick(){
        Task {
            try await viewModel.InitOriginCoreData()
        }
    }
    

    @objc func addbtnClick()  {
        let bookNoteModel = BookNoteModel(bookName: "哈哈", age: 30)
        viewModel.addNewBookNote(bookNoteModel: bookNoteModel)
    }
    
    func updateUI(bookNoteModels: [BookNoteModel?]) {
        print("bookNoteModels:",bookNoteModels)
        var str = ""
        for item in bookNoteModels {
            str += item?.bookName ?? ""
        }
        self.textLabel?.text = str
    }
  
     
}
