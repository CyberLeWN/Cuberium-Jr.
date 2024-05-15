//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Depolama {
    string[] private mesajlar;
    address public kontratSahibi;
    mapping (address => bool) public izinliListesi;

    //bool veri yapıları: true (1) ya da false (0)

    //0x90EDB5533906B485EF8e5AF52b11B2aE9446136a => true
    //0xbd99FA9Be63E1d784a1cFc133A6c2CB7C8E9c63A => false
    //0x7a1683CE3736a7483B010a196fEc8985f0a95eA6 => false
    //0x445Fc5683c7bD3947Ee8EAEa15082Bf325f1C209 => false

    constructor() {
        kontratSahibi = msg.sender;
        izinliListesi[msg.sender] = true;
    }

    function mesajiGoruntule(uint256 index) public view returns(string memory) {
        return mesajlar[index];
    }

    function mesajEkle(string memory yeniMesaj) public sadeceIzinliListesi {
        mesajlar.push(yeniMesaj);
    }
    
    function mesajDegistir(string memory yeniMesaj, uint index) public sadeceIzinliListesi {
        mesajlar[index] = yeniMesaj;
    }

    function izinliAdresCikar(address yeniAdres) public sadeceSahip {
        izinliListesi[yeniAdres] = false;
    }

    function izinliAdresEkle(address yeniAdres) public sadeceSahip {
        izinliListesi[yeniAdres] = true;
    }

    modifier sadeceIzinliListesi {
        require(izinliListesi[msg.sender] == true);
        _;
    }
    modifier sadeceSahip {
        require(kontratSahibi == msg.sender);
        _;
    }
}
