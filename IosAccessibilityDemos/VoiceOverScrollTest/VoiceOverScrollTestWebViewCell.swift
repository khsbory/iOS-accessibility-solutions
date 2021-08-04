//
//  VoiceOverScrollTestWebViewCell.swift
//  IosAccessibilityDemos
//
//  Created by KBIZ on 2021/08/04.
//  Copyright © 2021 Jeonggyu Park. All rights reserved.
//

import UIKit
import WebKit

class VoiceOverScrollTestWebViewCell: UITableViewCell {

    
    @IBOutlet weak var vContainer: UIView!
    
    var config: WKWebViewConfiguration?
    internal var mWebView: WKWebView?
    
    var mainUrl: String = "https://m.gmarket.co.kr/"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initWebView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func initWebView() {
        /// WKWebview Config 초기화
        if mWebView == nil {
            if let config = self.config {
                self.mWebView = WKWebView(frame: CGRect.zero, configuration: config)
            } else {
                let config = WKWebViewConfiguration()
                config.preferences.javaScriptEnabled = true
                config.preferences.javaScriptCanOpenWindowsAutomatically = true
                config.selectionGranularity = .character
                
                self.config = config
                self.mWebView = WKWebView(frame: CGRect.zero, configuration: config)
                
            }
            
        }
        
        guard let webView = mWebView else {
            return
        }
                
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        vContainer.addSubview(webView)
       
        webView.topAnchor.constraint(equalTo: self.vContainer.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.vContainer.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.vContainer.safeAreaLayoutGuide.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.vContainer.safeAreaLayoutGuide.bottomAnchor).isActive = true
         
        
        self.requestWebView(self.mainUrl)
    }
    
    
    func requestWebView(_ strUrl:String, _ parameters: [String:Any]? = nil) {
        
        guard let webView = mWebView else {
            return
        }
        
        if let value = URL(string: strUrl) {
            let request = URLRequest(url: value)
            
            webView.load(request)
        }
    }
}
