//
//  TableViewController.swift
//  MilestoneChallenge4
//
//  Created by 원현식 on 2020/03/11.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var images = [Image]()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraTapped))
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "images") as? Data{
            let jsonDecoder = JSONDecoder()
            
            do {
                images = try jsonDecoder.decode([Image].self, from: savedData)
            } catch  {
                print("decode error")
            }
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        
        cell.textLabel?.text = images[indexPath.row].caption
        let path = getDocumentsDirectory().appendingPathComponent(images[indexPath.row].image)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    
    // MARK: - Private Methods
    @objc private func cameraTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: true)
            
        } else {
            picker.sourceType = .photoLibrary
            present(picker, animated: true)
            print("시뮬레이터에선 카메라를 사용할 수 없습니다.")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func save() {
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(images) {
            let defualts = UserDefaults.standard
            defualts.set(savedData, forKey: "images")
        } else {
            print("Failed to save people.")
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegImage = image.jpegData(compressionQuality: 0.8) {
            try? jpegImage.write(to: imagePath)
        }
        
        dismiss(animated: true, completion: nil)
        
        let ac = UIAlertController(title: nil, message: "이미지의 캡션을 입력하세요.", preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            if let caption = ac?.textFields?[0].text {
                let image = Image(image: imageName, caption: caption)
                self?.images.append(image)
                self?.tableView.reloadData()
                self?.save()
            }
        }
        
        ac.addAction(action)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"  {
            if let destinationController = segue.destination as? DetailViewController {
                if let cell = sender as? UITableViewCell,let indexPath = tableView.indexPath(for: cell) {
                    destinationController.caption = images[indexPath.row].caption
                    let path = getDocumentsDirectory().appendingPathComponent(images[indexPath.row].image)
                    destinationController.image = UIImage(contentsOfFile: path.path)
                }
            }
        }
    }
    
    
}
