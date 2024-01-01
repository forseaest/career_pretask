//
//  main.swift
//  contact_management
//
//  Created by H on 1/2/24.
//

import Foundation

var userInfo: String = ""

func checkInfo(info: [String]) {
    let name = info[0].replacingOccurrences(of: " ", with: "") // 입력된 이름 안의 띄어쓰기 제거
    let age = info[1].replacingOccurrences(of: " ", with: "") // 입력된 나 안의 띄어쓰기 제거
    let address = info[2].replacingOccurrences(of: " ", with: "") // 입력된 연락처 안의 띄어쓰기 제거
    
    if checkAge(age: age) == false {
        print("입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return
    }
    
    if checkAddress(address: address) == false {
        print("입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return
    }
    
    print("입력한 정보는 \(age)세 \(name)(\(address))입니다.")
}

func checkAge(age: String) -> Bool {
    if let safeAge = Int(age) {
        return true
    } else {
        return false
    }
}

func checkAddress(address: String) -> Bool {
    let splitAddress = address.split(separator: "-")
    
    if splitAddress.count == 3 {
        return true
    } else {
        return false
    }
}

print("연락처 정보를 입력해주세요 : ", terminator: "")

if let inputInfo = readLine() {
    let inputInfoArray = inputInfo.split(separator: "/").map { String($0) }
    let inputInfoCount = inputInfoArray.count
    
    if inputInfoCount == 0 {
        print("아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요.")
    } else if inputInfoCount == 1 || inputInfoCount == 2 {
        print("입력 정보가 누락되었습니다. 입력 형식을 확인해주세요.")
    } else {
        checkInfo(info: inputInfoArray)
    }
}

