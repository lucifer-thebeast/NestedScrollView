//
//  HeaderView.swift
//  NestedScrollView
//
//  Created by Ronillo Ang on 1/25/23.
//

import Foundation
import UIKit

class HeaderView : UIView {
    
    private var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: frame)
        imageView?.contentMode = .scaleAspectFit
        imageView?.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if let imageView = self.imageView {
            addSubview(imageView)
        }
    }
    
    func loadImageFromUrl(path: String) {
        guard let url = URL(string: path) else {
            return
        }
        imageView?.setImageFrom(from: url, contentMode: .scaleAspectFill)
    }
}

extension UIImageView {
    
    func setImageFrom(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
