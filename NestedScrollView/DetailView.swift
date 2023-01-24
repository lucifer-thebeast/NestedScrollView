//
//  DetailView.swift
//  NestedScrollView
//
//  A demonstration of how to insert a view and a webview inside a scroll view.
//
//  Created by Ronillo Ang on 1/20/23.
//

import Foundation
import UIKit
import WebKit

class DetailView : UIView {
    
    private var webView: WKWebView?
    private var header: HeaderView?
    private var scrollView: UIScrollView?
    private let headerViewHeight = 300.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerViewHeight))
        
        webView = WKWebView(frame: CGRect(x: 0, y: headerViewHeight + 10, width: UIScreen.main.bounds.width, height: .zero), configuration: WKWebViewConfiguration())
    }
    
    override func layoutSubviews() {
        self.scrollView = UIScrollView()
        
        if let scrollView = self.scrollView {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(scrollView)
            scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            
            if let header = self.header {
                header.backgroundColor = UIColor.black
                header.loadImageFromUrl(path: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")
                scrollView.addSubview(header)
            }
            
            if let webView = self.webView {
                webView.scrollView.isScrollEnabled = false
                webView.navigationDelegate = self
                webView.loadHTMLString(Data().detailString, baseURL: nil)
                scrollView.addSubview(webView)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.isLoading == false {
            if let scrollView = self.scrollView {
                let headerViewHeight = self.headerViewHeight + 10
                webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (result, error) in
                    if let height = result as? CGFloat {
                        webView.frame.size.height = height
                        scrollView.contentSize.height = height + headerViewHeight
                    }
                })
            }
        }
    }
}

private struct Data {

    let detailString = """
        <html>
           <head>
              <meta name=\"viewport\" content=\"width=\(UIScreen.main.bounds.width); initial-scale=1.0; minimum-scale=1.0;\"/>
           </head>
            <body>
            <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vulputate quam diam, sodales luctus velit eleifend vitae. Nullam at aliquet libero. In molestie eleifend aliquet. Nullam nec tortor id ligula tincidunt tempus id nec neque. Nam blandit augue vel laoreet finibus. Cras sollicitudin, est at condimentum placerat, dui urna eleifend lorem, vitae pharetra ligula nulla nec risus. Suspendisse urna massa, commodo in aliquet quis, pulvinar vel massa.</p>

            <p>
            Quisque dapibus metus vitae ante cursus dictum. Pellentesque et mi iaculis urna posuere ullamcorper ut vel nunc. Aenean rhoncus ligula non massa accumsan lobortis sit amet quis dui. Nulla vitae sapien nunc. Proin ullamcorper quis diam ut feugiat. Suspendisse enim dolor, luctus ac justo in, vestibulum porta lectus. Duis pellentesque ipsum eu turpis faucibus malesuada. Nam pellentesque finibus scelerisque. Nulla rhoncus quam a massa lacinia, et imperdiet odio convallis. Maecenas sollicitudin libero vitae elit lacinia dictum. Donec blandit maximus auctor. Nunc leo augue, rutrum vitae odio sit amet, pellentesque pharetra libero. In ut ipsum mollis, fermentum sem at, luctus lacus. Sed lacinia vitae metus vitae sodales.</p>

            <p>
            Pellentesque erat erat, facilisis at suscipit sed, aliquet nec diam. Praesent tincidunt bibendum est, a lobortis libero imperdiet et. Vestibulum non auctor nibh. Praesent dignissim scelerisque facilisis. Nulla eu tincidunt felis. Proin blandit sit amet nisl et tristique. Fusce eget varius neque, et facilisis orci. Etiam dignissim erat at laoreet dignissim.</p>

            <p>
            Nullam finibus consectetur mauris, ac eleifend dolor lobortis quis. Sed et urna vel sapien euismod pretium. Pellentesque sit amet augue ipsum. Proin pellentesque imperdiet augue, in euismod ante fermentum in. Donec id leo augue. Nunc ligula sapien, vulputate sed mattis quis, malesuada non risus. Aenean eget feugiat mauris. Sed id sem sit amet lectus porttitor pellentesque quis eu augue. Maecenas dapibus sagittis arcu. Donec accumsan nisi vel sapien consectetur pulvinar.</p>

            <p>
            Nam eleifend tortor ut vehicula blandit. Curabitur a diam dolor. Donec a tempus orci, non aliquet velit. Nulla cursus id dolor vel egestas. Aliquam lectus nisl, sodales ut nibh eu, mollis ultricies ex. Integer a nisl vel libero lacinia aliquam. Mauris ornare lobortis mauris, eu scelerisque est faucibus rutrum. Donec fermentum enim id aliquet egestas. Quisque condimentum eget felis eu congue. Cras sed gravida nisl, vitae convallis magna. Aliquam a porta massa.</p>

            <p>
            Vivamus eu lacus non tortor condimentum auctor. Maecenas rutrum metus tellus, vel sagittis ipsum venenatis a. Vestibulum est risus, hendrerit quis condimentum tristique, tincidunt sed libero. Proin massa enim, laoreet sed quam vitae, vehicula mollis odio. Pellentesque et eleifend urna. Praesent nec lacinia nunc. Aenean semper libero sed laoreet imperdiet. Mauris hendrerit neque sit amet nisi egestas aliquam. Proin tortor nulla, suscipit at convallis quis, ornare quis leo. Vestibulum sed malesuada arcu, non volutpat sapien. Morbi ac massa ut lectus condimentum accumsan eu quis ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;</p>

            <p>
            Nullam posuere consectetur diam, vel porttitor erat ullamcorper sodales. Sed ac tempus ligula. Fusce sollicitudin tempor lorem sed interdum. Sed consectetur felis et maximus tincidunt. Duis at dolor lectus. Proin sapien mi, ultricies sit amet pellentesque in, tempus in neque. Sed interdum aliquam vulputate. Curabitur gravida auctor nisl, rutrum ultricies turpis porttitor eget.</p>

            <p>
            Pellentesque in nunc nunc. Donec in semper libero, sit amet bibendum dolor. Vivamus non pulvinar libero, eget luctus tellus. In convallis efficitur dui et mollis. Morbi interdum eros sed ante facilisis, eget congue sapien venenatis. Suspendisse congue lorem id eros dapibus, et hendrerit libero gravida. Nullam blandit auctor ligula, id mattis augue facilisis eu. Curabitur et vehicula justo, eu tincidunt turpis. Morbi imperdiet facilisis ligula. Integer sollicitudin aliquam erat, non dignissim lorem sagittis vitae. Sed sodales nibh ac vestibulum ornare. Duis placerat dapibus lacinia. Maecenas eros sem, lobortis vel convallis a, suscipit sit amet augue. Ut nec pretium dui, eget pharetra metus. Sed purus dolor, molestie in justo eget, accumsan porta diam.</p>

            <p>
            Ut tortor sapien, finibus in scelerisque eget, venenatis sit amet metus. Ut eu purus ligula. Integer accumsan tristique sem sed pharetra. Curabitur a lobortis nisi. Cras sodales augue ut dictum lacinia. Praesent dictum rutrum ante. Cras sapien arcu, sollicitudin et sem vel, placerat volutpat magna. In vitae nisi metus. Duis tincidunt laoreet lacus eu porta. Curabitur sit amet iaculis diam. Mauris malesuada lacinia orci vitae luctus.</p>

            <p>
            Duis rhoncus, arcu elementum ultricies rutrum, lacus ante malesuada purus, a ullamcorper tellus ligula eget tortor. Curabitur pulvinar erat et mollis sollicitudin. Nullam id augue ac quam blandit cursus nec quis lorem. Donec commodo rutrum sapien ut commodo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis varius, risus a rhoncus gravida, mi neque ultrices nibh, eget vehicula leo magna eget tortor. Duis tristique vestibulum odio, sit amet convallis ante dapibus a. Integer aliquet odio enim, quis fringilla arcu dignissim sed. Phasellus nec dui dapibus felis convallis faucibus at a ante. Nulla in libero varius, faucibus velit nec, malesuada libero. Sed tortor quam, aliquam in velit mattis, fringilla sagittis turpis. Aliquam vel vehicula lorem. Curabitur dictum pulvinar auctor. Quisque mattis scelerisque consequat. Etiam porta semper lectus, quis dignissim ligula imperdiet et. Aliquam mollis lorem sit amet tortor scelerisque, eget suscipit turpis iaculis.</p>
        </body></html>
    """
}
