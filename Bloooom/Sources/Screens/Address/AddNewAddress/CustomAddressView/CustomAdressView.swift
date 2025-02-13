import UIKit

class CustomAdressView: UIView {

    private let cityView = UIView(backgroundColor: .clear)
    let cityLabel = UILabel(text: "ГОРОД", font: 8, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let cityNameLabel = UILabel(text: "", font: 12, textColor: .black)
    private let citySeperator = UIView(backgroundColor: .black)
    private let streetView = UIView(backgroundColor: .clear)
    let streetLabel = UILabel(text: "УЛИЦА", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let streetLabel1 = UILabel(text: "УЛИЦА", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let streetTF = UITextField(placeHolder: "", keyboard: .default)
    private let streetSeperator = UIView(backgroundColor: .black)
    private let buildingView = UIView(backgroundColor: .clear)
    let buildingLabel = UILabel(text: "ДОМ/ЗДАНИЕ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let buildingLabel1 = UILabel(text: "ДОМ/ЗДАНИЕ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let buildingTF = UITextField(placeHolder: "", keyboard: .numberPad)
    private let buildingSeperator = UIView(backgroundColor: .black)
    private let appartmentView = UIView(backgroundColor: .clear)
    let appartmentLabel = UILabel(text: "КВАРТИРА/ОФИС", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let appartmentLabel1 = UILabel(text: "КВАРТИРА/ОФИС", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let appartmentTF = UITextField(placeHolder: "", keyboard: .numberPad)
    private let appartmentSeperator = UIView(backgroundColor: .black)
    private let entranceView = UIView(backgroundColor: .clear)
    let entranceLabel = UILabel(text: "ПОДЪЕЗД", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let entranceLabel1 = UILabel(text: "ПОДЪЕЗД", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let entranceTF = UITextField(placeHolder: "", keyboard: .numberPad)
    private let entranceSeperator = UIView(backgroundColor: .black)
    private let intercomeView = UIView(backgroundColor: .clear)
    let intercomeLabel = UILabel(text: "ДОМОФОН", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let intercomeLabel1 = UILabel(text: "ДОМОФОН", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let intercomTF = UITextField(placeHolder: "", keyboard: .numberPad)
    private let intercomSeperator = UIView(backgroundColor: .black)
    private let floorView = UIView(backgroundColor: .clear)
    let floorLabel = UILabel(text: "ЭТАЖ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let floorLabel1 = UILabel(text: "ЭТАЖ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let floorTF = UITextField(placeHolder: "", keyboard: .numberPad)
    private let floorSeperator = UIView(backgroundColor: .black)
    private let internationalCodeView = UIView(backgroundColor: .clear)
    let internationalCodeTF = UILabel(text: "+7", font: 12, textColor: .black)
    let internationCodeBtn = UIButton(btnImage: "expand")
    private let internationCodeSeperator = UIView(backgroundColor: .black)
    private let phoneNumberView = UIView(backgroundColor: .clear)
    let phoneNumberTF = UITextField(placeHolder: "", keyboard: .numberPad)
    private let phoneNumberSeperator = UIView(backgroundColor: .black)
    let phoneNumberLabel = UILabel(text: "НОМЕР ТЕЛЕФОНА", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let phoneNumberLabel1 = UILabel(text: "НОМЕР ТЕЛЕФОНА", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    private let commentView = UIView(backgroundColor: .clear)
    let commentLabel = UILabel(text: "КОМЕНТАРИЙ К ДОСТАВКЕ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let commentLabel1 = UILabel(text: "КОМЕНТАРИЙ К ДОСТАВКЕ", font: 12, textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    let commentTF = UITextField(placeHolder: "", keyboard: .default)
    private let commentSeperator = UIView(backgroundColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        hiddenLabels() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [cityLabel, cityNameLabel, citySeperator].forEach { cityView.addSubview($0) }
        [streetLabel, streetLabel1, streetTF, streetSeperator].forEach { streetView.addSubview($0) }
        [buildingLabel, buildingLabel1, buildingTF, buildingSeperator].forEach { buildingView.addSubview($0) }
        [appartmentLabel, appartmentLabel1, appartmentTF, appartmentSeperator].forEach { appartmentView.addSubview($0) }
        [entranceLabel, entranceLabel1, entranceTF, entranceSeperator].forEach { entranceView.addSubview($0) }
        [intercomeLabel, intercomeLabel1, intercomTF, intercomSeperator].forEach { intercomeView.addSubview($0) }
        [floorLabel, floorLabel1, floorTF, floorSeperator].forEach { floorView.addSubview($0) }
        [internationalCodeTF, internationCodeBtn, internationCodeSeperator].forEach { internationalCodeView.addSubview($0) }
        [phoneNumberLabel, phoneNumberLabel1, phoneNumberTF, phoneNumberSeperator].forEach { phoneNumberView.addSubview($0) }
        [commentLabel, commentLabel1, commentTF, commentSeperator].forEach { commentView.addSubview($0) }
        
        [
            cityView,
            streetView,
            buildingView,
            appartmentView,
            entranceView,
            intercomeView,
            floorView,
            internationalCodeView,
            phoneNumberView,
            commentView
        ].forEach { addSubview($0) }
    }
    
    private func hiddenLabels() {
        cityLabel.isHidden = false
        streetLabel.isHidden = true
        buildingLabel.isHidden = true
        appartmentLabel.isHidden = true
        entranceLabel.isHidden = true
        intercomeLabel.isHidden = true
        floorLabel.isHidden = true
        phoneNumberLabel.isHidden = true
        commentLabel.isHidden = true
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            cityView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cityView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityView.heightAnchor.constraint(equalToConstant: 46),
            
            cityLabel.topAnchor.constraint(equalTo: cityView.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: cityView.leadingAnchor),
            
            cityNameLabel.centerYAnchor.constraint(equalTo: cityView.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: cityView.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: cityView.trailingAnchor),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 45),
            
            citySeperator.bottomAnchor.constraint(equalTo: cityView.bottomAnchor),
            citySeperator.leadingAnchor.constraint(equalTo: cityView.leadingAnchor),
            citySeperator.trailingAnchor.constraint(equalTo: cityView.trailingAnchor),
            citySeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            streetView.topAnchor.constraint(equalTo: cityView.bottomAnchor, constant: 10),
            streetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            streetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            streetView.heightAnchor.constraint(equalToConstant: 46),
            
            streetLabel1.centerYAnchor.constraint(equalTo: streetView.centerYAnchor),
            
            streetLabel.topAnchor.constraint(equalTo: streetView.topAnchor),
            streetLabel.leadingAnchor.constraint(equalTo: streetView.leadingAnchor),
            
            streetTF.centerYAnchor.constraint(equalTo: streetView.centerYAnchor),
            streetTF.leadingAnchor.constraint(equalTo: streetView.leadingAnchor),
            streetTF.trailingAnchor.constraint(equalTo: streetView.trailingAnchor),
            streetTF.heightAnchor.constraint(equalToConstant: 45),
            
            streetSeperator.bottomAnchor.constraint(equalTo: streetView.bottomAnchor),
            streetSeperator.leadingAnchor.constraint(equalTo: streetView.leadingAnchor),
            streetSeperator.trailingAnchor.constraint(equalTo: streetView.trailingAnchor),
            streetSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            buildingView.topAnchor.constraint(equalTo: streetView.bottomAnchor, constant: 10),
            buildingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buildingView.heightAnchor.constraint(equalToConstant: 46),
            buildingView.widthAnchor.constraint(equalToConstant: 167),
            
            buildingLabel1.centerYAnchor.constraint(equalTo: buildingView.centerYAnchor),
            
            buildingLabel.topAnchor.constraint(equalTo: buildingView.topAnchor),
            buildingLabel.leadingAnchor.constraint(equalTo: buildingView.leadingAnchor),
            
            buildingTF.centerYAnchor.constraint(equalTo: buildingView.centerYAnchor),
            buildingTF.leadingAnchor.constraint(equalTo: buildingView.leadingAnchor),
            buildingTF.trailingAnchor.constraint(equalTo: buildingView.trailingAnchor),
            buildingTF.heightAnchor.constraint(equalToConstant: 45),
            
            buildingSeperator.bottomAnchor.constraint(equalTo: buildingView.bottomAnchor),
            buildingSeperator.leadingAnchor.constraint(equalTo: buildingView.leadingAnchor),
            buildingSeperator.trailingAnchor.constraint(equalTo: buildingView.trailingAnchor),
            buildingSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            appartmentView.topAnchor.constraint(equalTo: streetView.bottomAnchor, constant: 10),
            appartmentView.leadingAnchor.constraint(equalTo: buildingView.trailingAnchor, constant: 14),
            appartmentView.heightAnchor.constraint(equalToConstant: 46),
            appartmentView.widthAnchor.constraint(equalToConstant: 167),
            appartmentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            appartmentLabel1.centerYAnchor.constraint(equalTo: appartmentView.centerYAnchor),
            
            appartmentLabel.topAnchor.constraint(equalTo: appartmentView.topAnchor),
            appartmentLabel.leadingAnchor.constraint(equalTo: appartmentView.leadingAnchor),
            
            appartmentTF.centerYAnchor.constraint(equalTo: appartmentView.centerYAnchor),
            appartmentTF.leadingAnchor.constraint(equalTo: appartmentView.leadingAnchor),
            appartmentTF.trailingAnchor.constraint(equalTo: appartmentView.trailingAnchor),
            appartmentTF.heightAnchor.constraint(equalToConstant: 45),
            
            appartmentSeperator.bottomAnchor.constraint(equalTo: appartmentView.bottomAnchor),
            appartmentSeperator.leadingAnchor.constraint(equalTo: appartmentView.leadingAnchor),
            appartmentSeperator.trailingAnchor.constraint(equalTo: appartmentView.trailingAnchor),
            appartmentSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            entranceView.topAnchor.constraint(equalTo: buildingView.bottomAnchor, constant: 10),
            entranceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            entranceView.heightAnchor.constraint(equalToConstant: 46),
            entranceView.widthAnchor.constraint(equalToConstant: 167),
            
            entranceLabel1.centerYAnchor.constraint(equalTo: entranceView.centerYAnchor),
            
            entranceLabel.topAnchor.constraint(equalTo: entranceView.topAnchor),
            entranceLabel.leadingAnchor.constraint(equalTo: entranceView.leadingAnchor),
            
            entranceTF.centerYAnchor.constraint(equalTo: entranceView.centerYAnchor),
            entranceTF.leadingAnchor.constraint(equalTo: entranceView.leadingAnchor),
            entranceTF.trailingAnchor.constraint(equalTo: entranceView.trailingAnchor),
            entranceTF.heightAnchor.constraint(equalToConstant: 45),
            
            entranceSeperator.bottomAnchor.constraint(equalTo: entranceView.bottomAnchor),
            entranceSeperator.leadingAnchor.constraint(equalTo: entranceView.leadingAnchor),
            entranceSeperator.trailingAnchor.constraint(equalTo: entranceView.trailingAnchor),
            entranceSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            intercomeView.topAnchor.constraint(equalTo: appartmentView.bottomAnchor, constant: 10),
            intercomeView.leadingAnchor.constraint(equalTo: entranceView.trailingAnchor, constant: 14),
            intercomeView.heightAnchor.constraint(equalToConstant: 46),
            intercomeView.widthAnchor.constraint(equalToConstant: 167),
            intercomeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            intercomeLabel1.centerYAnchor.constraint(equalTo: intercomeView.centerYAnchor),
            
            intercomeLabel.topAnchor.constraint(equalTo: intercomeView.topAnchor),
            intercomeLabel.leadingAnchor.constraint(equalTo: intercomeView.leadingAnchor),
            
            intercomTF.centerYAnchor.constraint(equalTo: intercomeView.centerYAnchor),
            intercomTF.leadingAnchor.constraint(equalTo: intercomeView.leadingAnchor),
            intercomTF.trailingAnchor.constraint(equalTo: intercomeView.trailingAnchor),
            intercomTF.heightAnchor.constraint(equalToConstant: 45),
            
            intercomSeperator.bottomAnchor.constraint(equalTo: intercomeView.bottomAnchor),
            intercomSeperator.leadingAnchor.constraint(equalTo: intercomeView.leadingAnchor),
            intercomSeperator.trailingAnchor.constraint(equalTo: intercomeView.trailingAnchor),
            intercomSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            floorView.topAnchor.constraint(equalTo: entranceView.bottomAnchor, constant: 10),
            floorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            floorView.heightAnchor.constraint(equalToConstant: 46),
            floorView.widthAnchor.constraint(equalToConstant: 167),
            
            floorLabel1.centerYAnchor.constraint(equalTo: floorView.centerYAnchor),
            
            floorLabel.topAnchor.constraint(equalTo: floorView.topAnchor),
            floorLabel.leadingAnchor.constraint(equalTo: floorView.leadingAnchor),
            
            floorTF.centerYAnchor.constraint(equalTo: floorView.centerYAnchor),
            floorTF.leadingAnchor.constraint(equalTo: floorView.leadingAnchor),
            floorTF.trailingAnchor.constraint(equalTo: floorView.trailingAnchor),
            floorTF.heightAnchor.constraint(equalToConstant: 45),
            
            floorSeperator.bottomAnchor.constraint(equalTo: floorView.bottomAnchor),
            floorSeperator.leadingAnchor.constraint(equalTo: floorView.leadingAnchor),
            floorSeperator.trailingAnchor.constraint(equalTo: floorView.trailingAnchor),
            floorSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            internationalCodeView.topAnchor.constraint(equalTo: floorView.bottomAnchor, constant: 10),
            internationalCodeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            internationalCodeView.heightAnchor.constraint(equalToConstant: 46),
            internationalCodeView.widthAnchor.constraint(equalToConstant: 50),
            
            internationalCodeTF.centerYAnchor.constraint(equalTo: internationalCodeView.centerYAnchor),
            internationalCodeTF.leadingAnchor.constraint(equalTo: internationalCodeView.leadingAnchor),
            internationalCodeTF.heightAnchor.constraint(equalToConstant: 45),
            
            internationCodeBtn.centerYAnchor.constraint(equalTo: internationalCodeView.centerYAnchor),
            internationCodeBtn.trailingAnchor.constraint(equalTo: internationalCodeView.trailingAnchor),
            internationCodeBtn.heightAnchor.constraint(equalToConstant: 15),
            internationCodeBtn.widthAnchor.constraint(equalToConstant: 15),
            
            internationCodeSeperator.bottomAnchor.constraint(equalTo: internationalCodeView.bottomAnchor),
            internationCodeSeperator.leadingAnchor.constraint(equalTo: internationalCodeView.leadingAnchor),
            internationCodeSeperator.trailingAnchor.constraint(equalTo: internationalCodeView.trailingAnchor),
            internationCodeSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberView.topAnchor.constraint(equalTo: floorView.bottomAnchor, constant: 10),
            phoneNumberView.leadingAnchor.constraint(equalTo: internationalCodeView.trailingAnchor, constant: 10),
            phoneNumberView.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneNumberView.heightAnchor.constraint(equalToConstant: 46),
            
            phoneNumberLabel1.centerYAnchor.constraint(equalTo: phoneNumberView.centerYAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: phoneNumberView.topAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: phoneNumberView.leadingAnchor),
            
            phoneNumberTF.centerYAnchor.constraint(equalTo: phoneNumberView.centerYAnchor),
            phoneNumberTF.leadingAnchor.constraint(equalTo: phoneNumberView.leadingAnchor),
            phoneNumberTF.trailingAnchor.constraint(equalTo: phoneNumberView.trailingAnchor),
            phoneNumberTF.heightAnchor.constraint(equalToConstant: 45),
            
            phoneNumberSeperator.bottomAnchor.constraint(equalTo: phoneNumberView.bottomAnchor),
            phoneNumberSeperator.leadingAnchor.constraint(equalTo: phoneNumberView.leadingAnchor),
            phoneNumberSeperator.trailingAnchor.constraint(equalTo: phoneNumberView.trailingAnchor),
            phoneNumberSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: phoneNumberView.bottomAnchor, constant: 10),
            commentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentView.heightAnchor.constraint(equalToConstant: 46),
            
            commentLabel1.centerYAnchor.constraint(equalTo: commentView.centerYAnchor),
            
            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            
            commentTF.centerYAnchor.constraint(equalTo: commentView.centerYAnchor),
            commentTF.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentTF.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            commentTF.heightAnchor.constraint(equalToConstant: 45),
            
            commentSeperator.bottomAnchor.constraint(equalTo: commentView.bottomAnchor),
            commentSeperator.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentSeperator.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            commentSeperator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
