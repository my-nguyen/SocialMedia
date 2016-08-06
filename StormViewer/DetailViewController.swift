//
//  DetailViewController.swift
//  StormViewer
//
//  Created by My Nguyen on 8/4/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        // rightBarButtonItem: button that appears on the right of the navigation bar of the view controller
        // barButtonSystemItem: .Action displays an arrow coming out of a box
        // action: call the shareTapped() method when you're tapped
        // target: the method (shareTapped()) belongs to the current view controller (self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(shareSocialTapped))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareTapped() {
        // create a UIActivityViewController in order to share content with other apps and services
        // activityItems: an array of items to share
        // applicationActivities: an array of services to offer
        let viewController = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
        // where the UIActivityViewController should be anchored (appear from)
        // on iPhone, the UIActivityViewController takes up the full screen
        // on iPad, it is anchored as a popover to the right bar button item (the share button)
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        // present the UIActivityViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func shareSocialTapped() {
        let serviceType = SLServiceTypeFacebook
        // let serviceType = SLServiceTypeTwitter
        let viewController = SLComposeViewController(forServiceType: serviceType)
        viewController.setInitialText("Look at this great picture!")
        viewController.addImage(detailImageView.image!)
        viewController.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        presentViewController(viewController, animated: true, completion: nil)
    }
}

