//
//  ResourceDetailTableVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-16.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class ResourceDetailTableVC: UITableViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate,
                            PictureOnlyTVCDelegate, EmailTVCDelegate, PhoneNumberTVCDelegate, LinkTVCDelegate  {
    
    var resource : Resource!
    var sections = [ResourceSection]()
    var storedHeights : [IndexPath : CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PictureOnlyTVC.nib, forCellReuseIdentifier: PictureOnlyTVC.identifier)
        self.tableView.register(TextOnlyTVC.nib, forCellReuseIdentifier: TextOnlyTVC.identifier)
        self.tableView.register(PhoneNumberTVC.nib, forCellReuseIdentifier: PhoneNumberTVC.identifier)
        self.tableView.register(EmailTVC.nib, forCellReuseIdentifier: EmailTVC.identifier)
        self.tableView.register(LinkTVC.nib, forCellReuseIdentifier: LinkTVC.identifier)
        self.tableView.register(AddressTVC.nib, forCellReuseIdentifier: AddressTVC.identifier)
        self.tableView.register(SocialMediasTVC.nib, forCellReuseIdentifier: SocialMediasTVC.identifier)
        self.tableView.register(BusinessHoursTVC.nib, forCellReuseIdentifier: BusinessHoursTVC.identifier)
        
        sections = resource.sections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: UITableViewDataSource Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
            
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let h = storedHeights[indexPath] {
            return h
        }
        return UITableViewAutomaticDimension;
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].sectionType == .photo {
            return 180
        }
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        if let cell = section.tableView(tableView, representationForRowAtIndexPath: indexPath, resource: resource) as? NibCell {
            switch section.sectionType {
            case .photo:
                    cell.content = resource.photoLink!
                    if let image = (cell as? PictureOnlyTVC)?.pictureImageView?.image,
                        storedHeights[indexPath] == nil {
                         storedHeights[indexPath] = image.size.height
                    } else {
                        (cell as? PictureOnlyTVC)?.delegate = self
                    }
            case .description:
                    cell.content = resource.description
            case .address:
                    cell.content = resource.addresses![indexPath.row]
            case .contact:
                    let contactTypeItem = resource.contactInfo!.contactTypeItemForRow(idx:indexPath.row)
                    cell.content = contactTypeItem
                    if contactTypeItem?.type == .email {
                        (cell as? EmailTVC)?.delegate = self
                    } else if contactTypeItem?.type == .phone || contactTypeItem?.type == .tollfree {
                        (cell as? PhoneNumberTVC)?.delegate = self
                    } else if contactTypeItem?.type == .website {
                        (cell as? LinkTVC)?.delegate = self
                }
            case .social:
                    cell.content = resource.socialMedia!
            case .notes:
                    cell.content = resource.freeTexts![indexPath.row].toString()
            }
            return cell
        }
        print("Attention: Returning an empty cell")
        return UITableViewCell()
    }
    
    //MARK: PictureOnlyTVCDelegate methods:
    func pictureCellFinishedLoadingRemoteImage(size: CGSize, cell:UITableViewCell) {
        //This index path should always be 0,0 for our use case
        if let indexPath = self.tableView.indexPath(for: cell) {
            storedHeights[indexPath] = size.height
            self.tableView.beginUpdates()
            self.tableView.reloadRows(
                at: [indexPath],
                with: .fade)
            self.tableView.endUpdates()
        }
    }
    
    //MARK: PhoneNumberTVCDelegate methods:
    func cellWantsToCallPhone(number: String?) {
        if let phoneNumber = number,
            let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    func cellWantsToSendSMSTo(number: String?) {
        guard let num = number,
            MFMessageComposeViewController.canSendText()
            else { print("Cannot send SMS")
                   return }

            let controller = MFMessageComposeViewController()
            controller.body = "This is your message..."
            controller.recipients = [num]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
    }

    //MARK: LinkTVCDelegate methods:
    func cellWantsToOpenBrowser(url: String?) {
        guard let webAddress = url
            else { return }
        let svc = SFSafariViewController(url: URL(string: webAddress)!)
        self.present(svc, animated: true, completion: nil)
    }
    
    //MARK: EmailTVCDelegate methods:
    func cellWantsToSendEmail(to: String?) {
        guard let email = to,
            MFMailComposeViewController.canSendMail()
            else { return }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([email])
        composeVC.setSubject("Hello from test!")
        composeVC.setMessageBody("This is your message...", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    //MARK: MFMailComposeViewControllerDelegate methods:
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print("Email result: \(result)")
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: MFMessageComposeViewControllerDelegate methods:
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print("SMS result: \(result)")
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }


}

