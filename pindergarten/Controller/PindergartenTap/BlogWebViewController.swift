//
//  BlogWebViewController.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import UIKit
import WebKit

class BlogWebViewController: BaseViewController {

    //MARK: - Properties
    var blogUrl: String = ""
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = .mainTextColor
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        label.text = "블로그 리뷰"
        label.textColor = .mainTextColor
        return label
    }()

    private let seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF3F4F6)
        return view
    }()
    
    let webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: blogUrl)
        let request = URLRequest(url: url!)
        self.webView.allowsBackForwardNavigationGestures = true  //뒤로가기 제스쳐 허용
        webView.configuration.preferences.javaScriptEnabled = true  //자바스크립트 활성화
        webView.load(request)
        
        setWebViewDelegate()
        configureUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - Action
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func setWebViewDelegate() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(seperateLine)
        view.addSubview(webView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(22)
            make.left.equalTo(view).offset(8)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalTo(view)
        }

        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}

//MARK: - Extention
extension BlogWebViewController: WKUIDelegate, WKNavigationDelegate {
    // 중복적으로 reload 방지 위한 함수
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
         let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
         self.present(alertController, animated: true, completion: nil) }

     //confirm 처리
     func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

         let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
         alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
         self.present(alertController, animated: true, completion: nil)

     }

     // href="_blank" 처리
     func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

         if navigationAction.targetFrame == nil { webView.load(navigationAction.request)
         }
         return nil
     }
}
