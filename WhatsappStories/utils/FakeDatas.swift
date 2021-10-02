//
//  FakeDatas.swift
//  WhatsappStories
//
//  Created by ozan honamlioglu on 23.09.2021.
//

var status: [BaseStatus] = [
    BaseStatus(name: "Andy Mehalic", date: "10h ago", profilePic: "https://picsum.photos/300/300", id: "abc", seen: false),
    BaseStatus(name: "Artur Kedzior", date: "12h ago", profilePic: "https://picsum.photos/301/300", id: "xyz", seen: false),
    BaseStatus(name: "Ozan Honamlioglu", date: "a minute ago", profilePic: "https://picsum.photos/300/301", id: "ozz", seen: true)
]

func getNotSeen() -> [BaseStatus] {
    let collectedStatus = status.filter { $0.seen == false }
    return collectedStatus
}

func getSeen() -> [BaseStatus] {
    let collectedStatus = status.filter { $0.seen == true }
    return collectedStatus
}
