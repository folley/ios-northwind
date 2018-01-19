//
//  ItemEditViewController.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//

import UIKit
import CoreData

struct ItemEditConfiguration<T> {
    
    struct Item {
        let keyPath: AnyKeyPath
        let name: String
        
        // Required for custom types / relationships etc
        // Would be super great to use Swift type-safe key paths, but it's getting tricky when we want to
        // store writable key paths in a single collection.
        let writeKeyPath: String?
        let customClass: AnyClass?
        
        init(keyPath: AnyKeyPath, name: String,
             writeKeyPath: String? = nil, customClass: AnyClass? = nil) {
            self.keyPath = keyPath
            self.writeKeyPath = writeKeyPath
            self.name = name
            self.customClass = customClass
        }
    }
    
    let object: T
    let items: [Item]
}

private enum CellType {
    case stringCell
    case numberCell
    case boolCell
    case imageCell
    case singleRelationship
    
    func cellIdentifier() -> String {
        switch self {
        case .stringCell: return "stringCell"
        case .numberCell: return "numberCell"
        case .boolCell: return "boolCell"
        case .singleRelationship: return "singleRelationship"
        case .imageCell: return "imageCell"
        }
    }
    
    func nib() -> UINib {
        switch self {
        case .stringCell: return UINib(nibName: "TextEditTableViewCell", bundle: nil)
        case .numberCell: return UINib(nibName: "NumberEditTableViewCell", bundle: nil)
        case .boolCell: return UINib(nibName: "BoolEditTableViewCell", bundle: nil)
        case .singleRelationship: return UINib(nibName: "SingleRelationshipTableViewCell", bundle: nil)
        case .imageCell: return UINib(nibName: "PhotoTableViewCell", bundle: nil)
        }
    }
}

class ItemEditViewController<T: NSManagedObject>: UITableViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var configuration: ItemEditConfiguration<T>!
    var activePickerItem: ItemEditConfiguration<T>.Item?
    private var didSelectImage: ((UIImage) -> Void)?
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigation()
        tableView.keyboardDismissMode = .interactive
        tableView.rowHeight = 55.0
        
        self.title = "Object"
    }
    
    // MARK:
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash,
                                                            target: self,
                                                            action: #selector(didTapDelete(_:)))
    }
    
    private func setupTableView() {
        let supportedTypes: [CellType] = [.stringCell,
                                          .numberCell,
                                          .boolCell,
                                          .singleRelationship,
                                          .imageCell]
        for type in supportedTypes{
            tableView.register(type.nib(),
                               forCellReuseIdentifier: type.cellIdentifier())
        }
    }
    
    @objc private func didTapDelete(_ sender: Any) {
        let object = configuration.object
        object.managedObjectContext?.delete(object)
        object.managedObjectContext?.northwindSave()
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = configuration.items[indexPath.item]
        let cellType: CellType = cellTypeFor(item: item)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier(),
                                                 for: indexPath)

        configureCell(cell,
                      item: item)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = configuration.items[indexPath.item]
        let cellType: CellType = cellTypeFor(item: item)
        switch cellType {
        case .singleRelationship:
            if let pickerDesc = item.customClass as? PickerModelDescription.Type {
                let vc = UIStoryboard.pickerVC()
                vc.delegate = self
                vc.configuration = pickerDesc.pickerConfiguration()
                activePickerItem = item
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
    
    fileprivate func cellTypeFor(item: ItemEditConfiguration<T>.Item) -> CellType {
        let keyPath = item.keyPath
        let valueType = type(of: keyPath).valueType
        let value = configuration.object[keyPath: keyPath]
        
        var cellType: CellType?
        if valueType == String.self || valueType == String?.self {
            cellType = .stringCell
        }
        else if valueType == Int.self || valueType == Int?.self ||
            valueType == Int16.self || valueType == Int16?.self ||
            valueType == Int32.self || valueType == Int32?.self ||
            valueType == NSDecimalNumber.self || valueType == NSDecimalNumber?.self {
            cellType = .numberCell
        }
        else if valueType == Bool.self || valueType == Bool?.self {
            cellType = .boolCell
        }
        else if item.customClass == NSData.self {
            cellType = .imageCell
        }
        else if value is NSManagedObject {// || value is NSManagedObject? {
            cellType = .singleRelationship
        }
        
        else {
            // TODO:
            return .singleRelationship
        }
        
        return cellType!
    }
    
    fileprivate func configureCell(_ cell: UITableViewCell,
                                   item: ItemEditConfiguration<T>.Item) {
        let object = configuration.object
        let keyPath = item.keyPath
        let value = object[keyPath: keyPath]
        let valueType = type(of: keyPath).valueType
        let name = item.name
        
        if let textCell = cell as? TextEditTableViewCell {
            textCell.titleLabel.text = name
            textCell.textField.text = value as? String
            textCell.didEditText = { (text) in
                let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, String?>
                object[keyPath: writableKeyPath] = text
            }
        }
        else if let numberCell = cell as? NumberEditTableViewCell {
            let number = numberFromValue(value)
            var text = ""
            if let num = number {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                text = formatter.string(from: num)!
            }
            
            numberCell.titleLabel.text = name
            numberCell.textField.text = text
            numberCell.didChange = { (number) in
                
                if valueType == Int.self {
                    let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, Int>
                    object[keyPath: writableKeyPath] = number?.intValue ?? 0
                }
                else if valueType == Int16.self {
                    let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, Int16>
                    object[keyPath: writableKeyPath] = number?.int16Value ?? 0
                }
                else if valueType == Int32.self {
                    let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, Int32>
                    object[keyPath: writableKeyPath] = number?.int32Value ?? 0
                }
                else if valueType == NSDecimalNumber.self {
                    let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, NSDecimalNumber>
                    object[keyPath: writableKeyPath] = NSDecimalNumber(string: number?.stringValue)
                }
                else if valueType == NSDecimalNumber?.self {
                    let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, NSDecimalNumber?>
                    object[keyPath: writableKeyPath] = NSDecimalNumber(string: number?.stringValue)
                }
                else {
                    // Add support for other numbers (also optionals)
                    fatalError()
                }
                
                
            }
        }
        else if let boolCell = cell as? BoolEditTableViewCell {
            boolCell.titleLabel.text = name
            boolCell.valueSwitch.isOn = value as! Bool
            boolCell.didChange = { (isOn) in
                let writableKeyPath = keyPath as! ReferenceWritableKeyPath<T, Bool>
                object[keyPath: writableKeyPath] = isOn
            }
        }
        else if let relationshipCell = cell as? SingleRelationshipTableViewCell {
            relationshipCell.textLabel?.text = name
            
            if let pickerDesc = item.customClass as? PickerModelDescription.Type {
                let descriptionKey = pickerDesc.pickerConfiguration().descriptionKey
                let desc = (value as? NSObject)?.value(forKeyPath: descriptionKey) as? String
                relationshipCell.detailTextLabel?.text = desc
            }
        }
        else if let imageCell = cell as? PhotoTableViewCell {
            imageCell.titleLabel.text = name
            if let data = (value as? Data) {
                let image = UIImage(data: data)
                imageCell.photoImageView.image = image
            }
            else {
                imageCell.photoImageView.image = nil
            }
            imageCell.didSelect = { [weak self] in
                let pickerVC = UIImagePickerController()
                pickerVC.delegate = self
                self?.didSelectImage = { (image) in
                    let data = UIImageJPEGRepresentation(image, 1.0)
                    object.setValue(data, forKeyPath: item.writeKeyPath!)
                }
                self?.present(pickerVC, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            didSelectImage?(image)
            didSelectImage = nil
            tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ItemEditViewController: ObjectPickerDelegate {
    func objectPicker(_ picker: ObjectPickerViewController, didPick item: NSManagedObject) {
        let object = configuration.object
        
        // :( Don't know how to make it with type-safe key paths
        object.setValue(item, forKeyPath: activePickerItem!.writeKeyPath!)
        activePickerItem = nil
        navigationController?.popToViewController(self, animated: true)
        
        tableView.reloadData()
    }
}

extension ItemEditViewController {
    fileprivate func numberFromValue(_ value: Any?) -> NSNumber? {
        var number: NSNumber?
        if let intValue = value as? Int {
            number = NSNumber(value: intValue)
        }
        else if let int16Value = value as? Int16 {
            number = NSNumber(value: int16Value)
        }
        else if let int32Value = value as? Int32 {
            number = NSNumber(value: int32Value)
        }
        else if let decimalValue = value as? NSDecimalNumber {
            number = NSNumber(value: Double(truncating: decimalValue))
        }
        return number
    }
}

