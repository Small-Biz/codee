//
//  FullScreenView.swift
//  Codee
//
//  Created by Ray Cheng on 29/8/2022.
//

import UIKit

protocol FullScreenViewDelegate:AnyObject {
    func tapToContinue(_ controller: FullScreenView )
}

class FullScreenView: UIView {

    weak var delegate: FullScreenViewDelegate?
    var enable:Bool = false
    var tapHintsWork : DispatchWorkItem?
    var timer : Timer? = nil {
            willSet {
                timer?.invalidate()
            }
        }
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tapImageView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
        initUI()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("FullScreenView", owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask=[.flexibleHeight, .flexibleWidth]
    }
    
    private func initUI(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        contentView.addGestureRecognizer(tapGestureRecognizer)
        tapImageView.isHidden=true
        
    }

    public func enableView(){
        enable=true
        self.isHidden=false
        self.isUserInteractionEnabled=false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
            self.isUserInteractionEnabled=true
        }
        
        tapHintsWork = DispatchWorkItem(block: {
            if ( self.enable){
                self.startBlink()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: tapHintsWork!)

    }
    
    public func disableView(){
        enable=false
        self.isHidden=true
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer){
        print("table full screen view")
        tapHintsWork!.cancel()
        tapImageView.isHidden=true
        stopBlink()
        delegate?.tapToContinue(self)
    }
    
    @objc func blinkTapImageView(){
        tapImageView.isHidden = !tapImageView.isHidden
        }
    
    func startBlink() {
        stopBlink()
        guard self.timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.blinkTapImageView), userInfo: nil, repeats: true)
    }

    func stopBlink() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
}
