//
//  ViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 21/09/2020.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var demoTitles:[String] =
        ["웹뷰 데모", "접근성 포커스 데모", "페이지 전환 데모", "필터 데모", "뮤직플레이어", "드래그 & 드롭"]
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initTable()
        setScreenTitle()
    }
    
    private func setScreenTitle() {
        //아래 코드를 사용하면 Back 대신 title이 표시됨
        //navigationController?.navigationBar.topItem?.title = "iOS 접근성 데모"
        self.title = "iOS 접근성 데모"
    }

    private func initTable() {
        
        self.table.register(TableCell.self, forCellReuseIdentifier: "cell")
        self.table.delegate = self
        self.table.dataSource = self
        self.table.rowHeight = 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
                ) as!TableCell
        cell.demoTitle = demoTitles[indexPath.row]
        cell.layoutSubviews()
        cell.accessibilityTraits = .button
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
 if (indexPath.row == 0) {
            showScreenOnOtherStoryboard(storyboardName: "WebViewDemoMain", viewControllerStoryboardId: "webViewDemoMain")
        } else if (indexPath.row == 1) {
            showScreenOnOtherStoryboard(storyboardName: "AccessibilityFocusDemoMain", viewControllerStoryboardId: "accessibilityFocusDemoMain")
        } else if (indexPath.row == 2) {
            showScreenOnOtherStoryboard(storyboardName: "VerticalScrollDemo2Main", viewControllerStoryboardId: "verticalScrollDemo2Main")
        } else if (indexPath.row == 3) {
            showScreenOnOtherStoryboard(storyboardName: "FilterDemoMain", viewControllerStoryboardId: "filterDemoMain")
        } else if (indexPath.row == 4) {
            showScreenOnOtherStoryboard(storyboardName: "MusicPlayerMain", viewControllerStoryboardId: "music_player_main")
        } else if (indexPath.row == 5) {
            showScreenOnOtherStoryboard(storyboardName: "DragNDropMain", viewControllerStoryboardId: "drag_n_drop_main")
        }
        //return nil을 명시하면 다른화면에서 돌아왔을 때 선택됨이라고 음성안내하지 않음
        return nil
    }
    
    private func showScreenOnOtherStoryboard(storyboardName:String, viewControllerStoryboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        viewController.modalPresentationStyle = .fullScreen
        //self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

