// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegisterDisaster {
    address public owner; // เก็บข้อมูลของเจ้าของ Smart Contract (ใช้ใน Constructor)
    struct Person {
        string idCard; // รหัสบัตรประชาชน
        string firstName; // ชื่อ
        string lastName; // นามสกุล
        string addr; // ที่อยู่
    }

    Person[] private people; // สร้างตัวแปรอาเรย์ของประเภท Person เพื่อเก็บข้อมูลผู้คนที่จะลงทะเบียน
    mapping(string => uint256) private idToIndex; // สร้างตัวแปรแมพของประเภท uint256 เพื่อเก็บข้อมูลดัชนีของผู้คนตามรหัสบัตรประชาชน

    // constructor คือฟังก์ชันที่จะถูกเรียกใช้งานเมื่อมีการสร้างอินสแตนซ์ของ Smart Contract
    // msg.sender คือตัวแปรที่จะเก็บข้อมูลของผู้ที่สร้างอินสแตนซ์ของ Smart Contract
    constructor() {
        owner = msg.sender;
    }

    // ฟังก์ชันสำหรับลงทะเบียนผู้เข้าร่วม
    function registerPerson(
        string memory _idCard,
        string memory _firstName,
        string memory _lastName,
        string memory _address
    ) public {
        Person storage p = people.push();
        p.idCard = _idCard;
        p.firstName = _firstName;
        p.lastName = _lastName;
        p.addr = _address;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมทั้งหมด
    function getAll() public view returns (Person[] memory) {
        return people;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี index ที่กำหนด (ควรอ้างอิง index จากการลงทะเบียน)
    function getPerson(uint256 index) public view returns (Person memory) {
        Person storage p = people[index];
        return p;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี idCard ที่กำหนด
    // ใช้ idToIndex เพื่อหาดัชนีของผู้เข้าร่วมที่มี idCard ตรงกัน
    function getID(string memory _idCard) public view returns (Person memory) {
        for (uint i = 0; i < people.length; i++) {
        if (keccak256(abi.encodePacked(people[i].idCard)) == keccak256(abi.encodePacked(_idCard))) {
            Person storage p = people[i];
            return p;
        }
    }
    revert("Person not found");
    }
}
