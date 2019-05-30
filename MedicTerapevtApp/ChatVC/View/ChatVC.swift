//
//  ChatVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 20/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import RxSwift
import RxKeyboard

class ChatVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var viewUnderTF: SimpleGradientView!
    @IBOutlet weak var constrHeaderTop: NSLayoutConstraint!
    @IBOutlet weak var viewSend: ViewUnderTextFields!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imPatient: UIImageView!
    
    
    private var rxFirstCircle = true
    private var topSafeArea: CGFloat = 0
    private var bottomSafeArea: CGFloat = 0
    private var keyboardHeight: CGFloat = 0
    
    
    var currentPatientName: String?
    
    
    private var chatService = ChatService.standard
    
    
    var messageArr: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(currentPatientName ?? "")
        
        addObservers()
        
        fetchPastMessages()
        
        configureTFMessage()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        observeKeyboard()
        scrollToBottom()
    }
    
    
    private func setTitle(_ title: String) {
        
        self.title = title
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHistoryMessages),
                                               name: NSNotification.Name(rawValue: NotificationNames.messagesFetched.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showRecievedMessage), name: NSNotification.Name(NotificationNames.newMessage.rawValue), object: nil)
    }
    
    func scrollToBottom() {
        let indexPath = IndexPath(row: messageArr.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func fetchPastMessages() {
        
        MessageHistoryService.fetchMessages()
    }
    
    @objc private func showHistoryMessages() {
        
        messageArr = MessageHistoryService.messages
        tableView.reloadData()
        scrollToBottom()
    }
    
    @objc private func showRecievedMessage() {
        
        guard let newMessage = chatService.lastMessage else { return }
        visualiseRecievingMessage(text: newMessage.text, time: newMessage.time, contentType: newMessage.contentType, image: newMessage.image)
    }
    
    
    //MARK: Клавиатура
    
    private func observeKeyboard() {
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
        if rxFirstCircle {
            
            RxKeyboard.instance.visibleHeight
                .drive(onNext: { (height) in
                    if self.rxFirstCircle {
                        self.rxFirstCircle = false
                        return
                    }
                    if height == 0 {
                        self.keyboardHide(height: self.keyboardHeight - self.bottomSafeArea)
                        print("Опустил клавиатуру")
                    } else {
                        self.keyboardUp(height: height - self.bottomSafeArea)
                        self.keyboardHeight = height
                        print("Поднял клавиатуру")
                        print("safeAreaBottom = \(self.bottomSafeArea)")
                    }
                },
                       onCompleted: {
                        print("Готово")
                })
            
        } 
        
        
    }
    
    private func keyboardUp(height: CGFloat) {
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
        print(bottomSafeArea)
        
        self.view.frame.origin.y -= height
        constrHeaderTop.constant += height
     //   viewSend.shadowView.frame.origin.y += bottomSafeArea
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        scrollToBottom()
        
    }
    
    private func keyboardHide(height: CGFloat) {
        
        self.view.frame.origin.y += height
        constrHeaderTop.constant -= height
      //  viewSend.shadowView.frame.origin.y -= bottomSafeArea
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Конец работы с клавиатурой
    
    
    private func configureTFMessage() {
        
        tfMessage.delegate = self
        tfMessage.layer.cornerRadius = 8
        
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        tfMessage.leftViewMode = .always
        tfMessage.leftView = spacerView
    }
    
    
    private func visualiseSendingMessage(text: String, time: Date, contentType: MessageContentType, image: UIImage? = nil) {
        
        messageArr.append(Message(text: text, sender: .user, time: time, contentType: contentType, image: image))
        tfMessage.text = ""
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: messageArr.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        scrollToBottom()
        
    }
    
    private func visualiseRecievingMessage(text: String, time: Date, contentType: MessageContentType, image: UIImage? = nil) {
        
        messageArr.append(Message(text: text, sender: .penPal, time: time, contentType: contentType, image: image))
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: messageArr.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        scrollToBottom()
        
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            visualiseSendingMessage(text: "", time: Date(), contentType: .photo, image: pickedImage)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: IBActions
    @IBAction func butSendTapped(_ sender: UIButton) {
        
        guard let text = tfMessage.text else { return }
        
        chatService.sendMessage(Message(text: text, sender: .user, time: Date(), contentType: .text))
        visualiseSendingMessage(text: text, time: Date(), contentType: .text)
        
    }
    
    @IBAction func butAddImageTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func butCloseTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "chatClosed"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
