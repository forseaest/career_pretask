//
//  main.swift
//  contact_management
//
//  Created by H on 1/2/24.
//

import Foundation

var addressList: [(String, String, String)] = []

// MARK: - 0) 메뉴

/// 메뉴를 표기하는 함수
func showMenu() {
    print("1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료")
    print("메뉴를 선택해주세요 : ", terminator: "")
}

/// 메뉴 선택에 대한 사용자 입력을 받는 함수
func selectMenu() {
    var userInput = readLine()
    
    if let selectedMenu = userInput {
        switch selectedMenu {
        case "1":
            verifyAddAddress()
        case "2":
            showEntireAddress()
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

/// 연락처 추가에서 사용자 입력을 검증하는 함수
func verifyAddAddress() {
    print("연락처 정보를 입력해주세요 : ", terminator: "")
    
    if let userInput = readLine() {
        let splitUserInput = userInput.split(separator: "/").map { String($0) }
        let splitUserInputCount = splitUserInput.count
        
        if splitUserInputCount == 0 {
            print("아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요.")
        } else if splitUserInputCount == 1 || splitUserInputCount == 2 {
            print("입력 정보가 누락되었습니다. 입력 형식을 확인해주세요.")
        } else {
            let name = splitUserInput[0].replacingOccurrences(of: " ", with: "") // 입력된 이름 안의 띄어쓰기 제거
            let age = splitUserInput[1].replacingOccurrences(of: " ", with: "") // 입력된 나 안의 띄어쓰기 제거
            let address = splitUserInput[2].replacingOccurrences(of: " ", with: "") // 입력된 연락처 안의 띄어쓰기 제거
            
            if checkName(name: name) == false {
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
            
            addAddress(name: name, age: age, address: address)
            print("입력한 정보는 \(age)세 \(name)(\(address))입니다.")
        }
    }
}

/// 연락처 목록에 입력된 연락처를 추가하는 함수
func addAddress(name: String, age: String, address: String) {
    addressList.append(("\(name)", "\(age)", "\(address)"))
    sortAddressList()
}

/// 사용자가 입력한 이름정보를 검증하는 함수
func checkName(name: String) -> Bool {
    if name == "" {
        return false
    } else {
        return true
    }
}

/// 사용자가 입력한 나이정보를 검증하는 함수
func checkAge(age: String) -> Bool {
    if let safeAge = Int(age) {
        return true
    } else {
        return false
    }
}

/// 사용자가 입력한 연락처정보를 검증하는 함수
func checkAddress(address: String) -> Bool {
    let splitAddress = address.split(separator: "-")
    
    if splitAddress.count == 3 {
        return true
    } else {
        return false
    }
}

// MARK: - 2) 연락처 목록보기

/// 연락처 전체 목록을 출력하는 함수
func showEntireAddress() {
    for userInfo in addressList {
        print("- \(userInfo.0) / \(userInfo.1) / \(userInfo.2)")
    }
}

/// 연락처 목록을 이름의 알파벳 순으로 정렬하는 함수
func sortAddressList() {
    addressList = addressList.sorted { lhsAddress, rhsAddress in
        return lhsAddress.0 < rhsAddress.0
    }
}

// MARK: - 3) 연락처 검색

/// 연락처 검색에서 사용자 입력을 검증하는 함수
func searchAddress() {
    print("연락처에서 찾을 이름을 입력해주세요 : ", terminator: "")
    let inputName = readLine()
    
    if let safeName = inputName {
        showAddressByName(inputName: safeName)
    } else {
        print("입력이 잘못되었습니다. 확인 후 다시 입력해주세요.")
    }
}

/// 특정 이름의 연락처 목록을 출력하는 함수
func showAddressByName(inputName: String) {
    let inputNameList = addressList.filter { (name, age, address) in
        return name == inputName
    }
    
    if inputNameList.isEmpty {
        print("연락처에 \(inputName) 이(가) 없습니다.")
    } else {
        for userInfo in inputNameList {
            print("- \(userInfo.0) / \(userInfo.1) / \(userInfo.2)")
        }
    }
}

// MARK: - 실행

while true {
    showMenu()
    selectMenu()
}
