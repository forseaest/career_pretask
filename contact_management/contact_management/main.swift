//
//  main.swift
//  contact_management
//
//  Created by H on 1/2/24.
//

import Foundation

var addressList: [(String, String, String)] = []

func showMenu() {
    print("1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료")
    print("메뉴를 선택해주세요 : ", terminator: "")
}

func selectMenu() {
    var userInput = readLine()
    
    if let selectedMenu = userInput {
        switch selectedMenu {
        case "1":
            addAddress()
        case "2":
            showAddress()
        case "3":
            searchAddress()
        case "x":
            print("[프로그램 종료]")
            return
        default:
            print("선택이 잘못되었습니다. 확인 후 다시 입력해주세요.")
        }
    } else {
        print("선택이 잘못되었습니다. 확인 후 다시 입력해주세요.")
    }
}

// MARK: - 1) 연락처 추가

func addAddress() {
    var userInfo: String = ""
    
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
}

func checkInfo(info: [String]) {
    let name = info[0].replacingOccurrences(of: " ", with: "") // 입력된 이름 안의 띄어쓰기 제거
    let age = info[1].replacingOccurrences(of: " ", with: "") // 입력된 나 안의 띄어쓰기 제거
    let address = info[2].replacingOccurrences(of: " ", with: "") // 입력된 연락처 안의 띄어쓰기 제거
    
    if name == "" {
        print("입력한 이름정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return
    }
    
    if checkAge(age: age) == false {
        print("입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return
    }
    
    if checkAddress(address: address) == false {
        print("입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
        return
    }
    
    addressList.append(("\(name)", "\(age)", "\(address)"))
    sortAddressList()
    
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

// MARK: - 2) 연락처 목록보기

func showAddress() {
    let alphabeticalList = addressList.sorted { lhsAddress, rhsAddress in
        return lhsAddress.0 < rhsAddress.0
    }
    
    for userInfo in addressList {
        print("- \(userInfo.0) / \(userInfo.1) / \(userInfo.2)")
    }
}

func sortAddressList() {
    addressList = addressList.sorted { lhsAddress, rhsAddress in
        return lhsAddress.0 < rhsAddress.0
    }
}

// MARK: - 3) 연락처 검색

func searchAddress() {
    print("연락처에서 찾을 이름을 입력해주세요 : ", terminator: "")
    let inputName = readLine()
    
    if let safeName = inputName {
        let inputNameList = addressList.filter { (name, age, address) in
            return name == safeName
        }
        
        if inputNameList.isEmpty {
            print("연락처에 \(safeName) 이(가) 없습니다.")
        } else {
            for userInfo in inputNameList {
                print("- \(userInfo.0) / \(userInfo.1) / \(userInfo.2)")
            }
        }
    } else {
        print("입력이 잘못되었습니다. 확인 후 다시 입력해주세요.")
    }
}

while true {
    showMenu()
    selectMenu()
}
