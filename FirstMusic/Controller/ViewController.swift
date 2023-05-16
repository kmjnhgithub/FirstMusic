//
//  ViewController.swift
//  FirstMusic
//
//  Created by mike liu on 2023/5/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]() // var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
        
    }
    
    func configureSongs() {
        songs.append(Song(name: "LOSE YOURSELF", albumName: "8 Mile", artistName: "Enimen", imageName: "cover1", trackName: "song1"))
        songs.append(Song(name: "初戀", albumName: "初戀", artistName: "宇多田光", imageName: "cover2", trackName: "song2"))
        songs.append(Song(name: "We Are", albumName: "Ambitions", artistName: "ONE OK ROCK", imageName: "cover3", trackName: "song3"))
    }
    
    // table
    
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        // cell的歌名和專輯名稱
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator // 添加cell右邊的箭頭指示器
        
        // 設定cell裡的image
        if let image = UIImage(named: song.imageName) {
            let newSize = CGSize(width: 90, height: 90) // set image size
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
            
            if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                cell.imageView?.image = newImage
            }
        }
        
        // 設定cell的字體與大小
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        
        return cell
    }
    
    // 設定每個cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 點擊此cell後取消選中的高亮度
        
        // present player
        let position = indexPath.row // 取得使用者點選的是第幾個row
        
        // 從 storyboard 中實例化 PlayerViewController
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
    
    

}



