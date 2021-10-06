//
//  FakeDatas.swift
//  WhatsappStories
//
//  Created by ozan honamlioglu on 23.09.2021.
//

var status: [BaseStatus] = [
    BaseStatus(name: "John Doe", date: "10h ago", profilePic: "https://picsum.photos/300/300", id: "abc", seen: false),
    BaseStatus(name: "Harry", date: "12h ago", profilePic: "https://picsum.photos/301/300", id: "xyz", seen: false),
    BaseStatus(name: "Oliver", date: "a minute ago", profilePic: "https://picsum.photos/300/301", id: "zfb", seen: true),
    BaseStatus(name: "Jack", date: "a minute ago", profilePic: "https://picsum.photos/302/300", id: "qweg", seen: true),
    BaseStatus(name: "Jacob", date: "a minute ago", profilePic: "https://picsum.photos/300/302", id: "fhjk", seen: true)
]

func getNotSeen() -> [BaseStatus] {
    let collectedStatus = status.filter { $0.seen == false }
    return collectedStatus
}

func getSeen() -> [BaseStatus] {
    let collectedStatus = status.filter { $0.seen == true }
    return collectedStatus
}
