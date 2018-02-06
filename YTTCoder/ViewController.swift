//
//  ViewController.swift
//  YTTCoder
//
//  Created by 秋文心理 on 2018/1/23.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit

class Student: YTTJson {
    var name: String!
    var age: Int!
    var gender: Bool?
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let data = try? [1, 3].ytt.toData() {
//            print(data)
//        }
//
//        print(NSKeyedArchiver.archivedData(withRootObject: [1, 3]))
        
        
        let string = "[{\n  \"name\" : \"Andy\",\n  \"age\" : 23,\n  \"gender\" : true\n},{\n  \"name\" : \"Andy\",\n  \"age\" : 23,\n  \"gender\" : true\n},{\n  \"name\" : \"Andy\",\n  \"age\" : 23,\n  \"gender\" : true\n},{\n  \"name\" : \"Andy\",\n  \"age\" : 23,\n  \"gender\" : true\n},{\n  \"name\" : \"Andy\",\n  \"age\" : 23,\n  \"gender\" : true\n} ]"
        
//        let stu = Student()
//        stu.name = "Andy"
//        stu.age = 23
//        stu.gender = true
//        print(try? stu.toJson() ?? "")
        
        
        
//        if let student = try? Student.initWithString(jsonStr: string) {
//            print(student.gender ?? "dddd", student.name)
//        }else {
//            print("error")
//        }
        
        if let arr = try? [Student].initWithString(jsonStr: string) {
            for stu in arr {
                print(stu.name, stu.age, stu.gender)
            }
        }
        
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

