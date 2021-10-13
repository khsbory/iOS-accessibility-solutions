//
//  ViewController.swift
//  IosAccessibilityDemos
//
//  Created by Jeonggyu Park on 21/09/2020.
//  Copyright © 2020 Jeonggyu Park. All rights reserved.
//

import UIKit


enum VoiceOverMode {
    case none
    case running
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var demoTitles:[String] =
        ["웹뷰 데모", "접근성 포커스 데모", "페이지 전환 데모", "필터 데모", "뮤직플레이어", "드래그 & 드롭", "롤링배너", "캐러셀 접근성", "설정", "화면스크롤","분리된 접근성 초점 개선","밀기 동작에 대한 접근성 데모","접근성 초점 재조정","보이스오버 스크롤 테스트","롤링배너 2탄","테이블뷰 순서이동 데모","테이블뷰 리로드 데모"]
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
        } else if (indexPath.row == 6) {
            showScreenOnOtherStoryboard(storyboardName: "RollingBanner", viewControllerStoryboardId: "rolling_banner_view_controller")
        } else if (indexPath.row == 7) {
            showScreenOnOtherStoryboard(storyboardName: "CarouselAccessibilityMain", viewControllerStoryboardId: "CarouselAccessibilityMain")
        } else if (indexPath.row == 8) {
            showScreenOnOtherStoryboard(storyboardName: "SettingMain", viewControllerStoryboardId: "setting_main")
        } else if (indexPath.row == 9) {
            showScreenOnOtherStoryboard(storyboardName: "ScreenScrollMain", viewControllerStoryboardId: "screen_scroll_main")
        } else if (indexPath.row == 10) {
            showScreenOnOtherStoryboard(storyboardName: "SeparateFocus", viewControllerStoryboardId: "SeparateFocusMain")
        } else if (indexPath.row == 11) {
            showScreenOnOtherStoryboard(storyboardName: "NewDragNDrop", viewControllerStoryboardId: "NewDragNDropMain")
        } else if (indexPath.row == 12) {
            showScreenOnOtherStoryboard(storyboardName: "ReadjustFocus", viewControllerStoryboardId: "ReadjustFocusMain")
        } else if (indexPath.row == 13) {
            showScreenOnOtherStoryboard(storyboardName: "VoiceOverScrollTest", viewControllerStoryboardId: "VoiceOverScrollTestMain")
        } else if (indexPath.row == 14) {
            showScreenOnOtherStoryboard(storyboardName: "RollingBanner2", viewControllerStoryboardId: "RollingBanner2Main")
        } else if (indexPath.row == 15) {
            showScreenOnOtherStoryboard(storyboardName: "TableViewMoveRowDemo", viewControllerStoryboardId: "TableViewMoveRowDemoMain")
        } else if (indexPath.row == 16) {
            showScreenOnOtherStoryboard(storyboardName: "ReloadingTableViewDemo", viewControllerStoryboardId: "ReloadingTableViewMain")
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

