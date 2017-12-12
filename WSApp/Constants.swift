//
//  Constants.swift
//  WSApp
//
//  Created by Pelorca on 06/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

struct Constants {
   static let token: String =  "token"
    static let kHttpEndpoint = "http://localhost:8000/api"
    
    func dispositivoOnline() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
    }
    
    static func showMessage(_ view:UIViewController, _ msg:String) {
        
        let myalert = UIAlertController(title: "Mensagem", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        myalert.addAction(UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            myalert.dismiss(animated: true)
        })
        view.present(myalert, animated: true)
        print("Mensagem: \(msg)")
    }
    
    
}
    
    enum I18n {
        static let msgLoginInvalido = I18n.tr("Localizable", "login.invalido")
        static let msgSenhaInvalida = I18n.tr("Localizable", "senha.invalida")
        static let msgLoginSenhaInvalidos = I18n.tr("Localizable", "login.ou.senha.invalidos")
        static let msgTituloInvalido = I18n.tr("Localizable", "titulo.invalido")
        static let msgDescricaoInvalida = I18n.tr("Localizable", "descricao.invalida")
        static let msgTarefaCadastradaComSucesso = I18n.tr("Localizable", "tarefa.cadastrada.com.sucesso")
        static let msgTarefaAlteradaComSucesso = I18n.tr("Localizable", "tarefa.alterada.com.sucesso")
        static let msgTarefaRemovidaComSucesso = I18n.tr("Localizable", "tarefa.removida.com.sucesso")
        static let msgErroTarefaRemovaida = I18n.tr("Localizable", "tarefa.falha.ao.remover")
    }
    
    extension I18n {
        private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
            let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
            return String(format: format, locale: Locale.current, arguments: args)
        }
    }
    
    private final class BundleToken {}


