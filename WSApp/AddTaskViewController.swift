//
//  AddTaskViewController.swift
//  WSApp
//
//  Created by Pelorca on 07/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var _titulo: String?
    var _isCompleto: Bool = false
    var _dataExpericao: Date?
    var _descricao: String?
    var id: String?
    
    var itemTask: TaskItem = TaskItem()
    
    var _editable: Bool = false
    
    @IBOutlet weak var txtDescricao: UITextView!
    
    
    @IBOutlet weak var txtTitulo: UITextField!
    
    
    
    
    @IBOutlet weak var isCompleto: UISwitch!
    
    @IBOutlet weak var dataExpericao: UIDatePicker!
    
    func addTask(_ edit: Bool) {
        
        let task = TaskEntity()
        task.id = UUID().uuidString
        task.expirationDate = itemTask.expirationDate
        task.descriptionTask =  itemTask.descriptionTask
        task.isComplete = itemTask.isComplete
        task.title = itemTask.title
        task.serverId = (itemTask.id != "" ? itemTask.id : nil)
        
        if !edit {
            Repository().save(data: task)
        } else {
            Repository().update(data: task)
        }
        
        
    }
   
    
    
    @IBAction func btnSalvar(_ sender: UIButton) {
        mountItem()
        
        if Constants().dispositivoOnline() {
            if !self._editable {
                TaskService().insert(task: self.itemTask , onSuccess: { response in
                    self.itemTask = (response?.body)!
                    self.navigationController?.popViewController(animated: true)
                }, onError: { _ in
                }, always: {
                     self.addTask(self._editable)
                })
                
            } else {
                TaskService().update(task: self.itemTask , onSuccess: { response in
                    self.itemTask = (response?.body)!
                }, onError: { _ in
                }, always: {
                     self.addTask(self._editable)
                    Constants.showMessage(self, I18n.msgTarefaAlteradaComSucesso)
                })
                
            }
        } else {
            if self._editable {
                 self.addTask(self._editable)
                
            } else {
                 self.addTask(self._editable)
            }
           
      }
    }
    
    func mountItem() {
        
        self.itemTask.descriptionTask = self.txtDescricao.text
        self.itemTask.expirationDate = self.dataExpericao.date.convertToString()
        self.itemTask.title =  self.txtTitulo.text
        self.itemTask.isComplete = self.isCompleto.isOn
        if _editable { self.itemTask.id = self.id }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if _editable {
            self.txtTitulo.text = self._titulo
            self.dataExpericao.date = self._dataExpericao!
            self.isCompleto.isOn = self._isCompleto
            self.txtDescricao.text = self._descricao
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
}



