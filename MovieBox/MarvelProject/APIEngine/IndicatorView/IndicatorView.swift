//
//  IndicatorView.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 omerfarukozturk. All rights reserved.
//

import UIKit
import Lottie

class IndicatorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewAnimate: AnimationView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupThisView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupThisView()
    }
    
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        self.viewAnimate.loopMode = .loop
        
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: IndicatorView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }

}
