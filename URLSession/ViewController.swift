//
//  ViewController.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loadGetMethod()
    }

    func loadGetMethod() {

        API.shared.load(resource: Resource<[Comment]>(url: .comments,
                                                         parameters: ["postId": "1"])) { result in
            switch result {
            case .success(let datas):
                dump(datas)
            case .failure(let error):
                print("Error", error.localizedDescription)

            }
        }
        
        
    }
    
    func loadPostMethod() {
        
        let resource = Resource<UserData>(url: .posts,
                                          method: .post(UserData(userID: 1,
                                                                 id: 111,
                                                                 title: "foo",
                                                                 body: "bar")))
        API.shared.load(resource: resource) { result in
            switch result {
            case .success(let datas):
                print(datas)
            case .failure(let error):
                print("Error", error.localizedDescription)

            }
        }
    }
    
    func loadPutMethod() {
        
        let resource = Resource<UserData>(url: .post(1),
                                          method: .put(UserData(userID: 1,
                                                                id: 1,
                                                                title: "foo",
                                                                body: "bar")))
        API.shared.load(resource: resource) { result in
            switch result {
            case .success(let datas):
                print(datas)
            case .failure(let error):
                print("Error", error.localizedDescription)

            }
        }
    }
    
    func loadPatchMethod() {
        
        let resource = Resource<UserData>(url: .post(1),
                                          method: .patch(UserData(userID: 1,
                                                                  id: 1,
                                                                  title: "foo",
                                                                  body: "bar")))
        
        API.shared.load(resource: resource) { result in
            switch result {
            case .success(let datas):
                print(datas)
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
    func loadDeleteMethod() {
        
        let resource = Resource<Bool?>(url: .post(1),
                                       method: .delete(UserData(userID: 1,
                                                                   id: 1,
                                                                   title: "foo",
                                                                   body: "bar")))
    
        
        API.shared.delete(resource: resource) { result in
            switch result {
            case .success(let datas):
                print(datas)
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
        
    }
    
    
    func loadImage() {

        API.shared.getData(from: URL(string: "https://robohash.org/123.png")!) { result in
            switch result {
            case .success(let data):
                if let imageData = data {
                    DispatchQueue.main.async() { [weak self] in
                        self?.imageView.image = UIImage(data: imageData)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

