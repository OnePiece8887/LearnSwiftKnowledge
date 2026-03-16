//
//  MainViewController.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/3/16.
//


import UIKit
import SwiftUI

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit主页"
        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.setTitle("Go to First SwiftUI", for: .normal)
        button.addTarget(self, action: #selector(goToFirstSwiftUI), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func goToFirstSwiftUI() {
        // 直接使用 NavigationManager push
        NavigationManager.shared.push(FirstSwiftUIView(), title: "First SwiftUI")
    }
}