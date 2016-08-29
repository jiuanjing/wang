var servercert = "MIIEKTCCA5KgAwIBAgIDEUUgMA0GCSqGSIb3DQEBBQUAMIGGMQswCQYDVQQGEwJDTjELMAkGA1UECBMCQkoxEDAOBgNVBAcTB0JlaWppbmcxDTALBgNVBAoTBFNDR0YxDTALBgNVBAsTBFNDR0YxIzAhBgkqhkiG9w0BCQEWFHNjZ2ZAY2FwaXRhbHdhdGVyLmNuMRUwEwYDVQQDEwxTQ0dGIFJPT1QgQ0EwHhcNMDkxMjE4MDkyNzE3WhcNMTkxMjE2MDkyNzE3WjAqMQswCQYDVQQGEwJDTjEbMBkGA1UEAxMSY2EuY2FwaXRhbHdhdGVyLmNuMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGS5Xzo8KLW6fxeUwZ2xKvuRePi+oMBcdIdo2FaxXwDS0Oj4+wmzBRXPSDgjzlHsdRudCMiOHGnI7gd/cgzB5AaP3fLkd2TFM80wyc0d4AFTZiMVA1Xo+kRlGbrR4PuDnw5KzgqGxH8wwcFBuLqRILt9EOXo6uCwRcwnH19WA1hwIDAQABo4IB/jCCAfowCwYDVR0PBAQDAgP4MEcGA1UdJQRAMD4GCCsGAQUFBwMBBggrBgEFBQcDAgYKKwYBBAGCNxQCAgYIKwYBBQUHAwUGCCsGAQUFBwMGBggrBgEFBQcDBzAJBgNVHRMEAjAAMEEGCCsGAQUFBwEBBDUwMzAxBggrBgEFBQcwAYYlaHR0cHM6Ly8xMjcuMC4wLjE6ODQ0My9ldGNhL2luZGV4Lmh0bTAdBgNVHQ4EFgQUWJ8yaxuSxBHn2pTD4r4YPW/sYYswgbsGA1UdIwSBszCBsIAUhOw/O+Q+sWz47CMEtjKTbMwcdLGhgYykgYkwgYYxCzAJBgNVBAYTAkNOMQswCQYDVQQIEwJCSjEQMA4GA1UEBxMHQmVpamluZzENMAsGA1UEChMEU0NHRjENMAsGA1UECxMEU0NHRjEjMCEGCSqGSIb3DQEJARYUc2NnZkBjYXBpdGFsd2F0ZXIuY24xFTATBgNVBAMTDFNDR0YgUk9PVCBDQYIJALH7r2h18z0FMBsGA1UdEQQUMBKgEAYKKwYBBAGCNxQCA6ACDAAwCQYDVR0SBAIwADA8BgNVHR8ENTAzMDGgL6AthitodHRwczovLzEyNy4wLjAuMTo4NDQzL2V0Y2EvY2VydHNydi9DUkwuY3JsMBEGCWCGSAGG+EIBAQQEAwIE8DANBgkqhkiG9w0BAQUFAAOBgQCjVxe1fb7BOo7QR+F3HJDnX8sMc9P9hhyNxncLh8KjJ7nasr843vqaSfwaV+rtDro2uBZ7dYmX6nTlK1HLzK8Y+9IjEpZJLm7pIQW0f2iwHMUngNrjmNcjAVjmk1PK6YaHABhQg+2DL98QO5gnuBtzMUrB39ry6sOZsWruO+0C2A==";
window.safeCtrlCOMUnInstalled = false;
function SafeCtrlCOMErrorTrap() {
    window.safeCtrlCOMUnInstalled = true;
}
//USB智能卡登录验证
function doEkeyAuth() {
    // 检测控件
    if (window.safeCtrlCOMUnInstalled == true) {
        $.messager.alert('消息', '计算机没有安装安全认证控件, 请安装控件程序!');
        return false;
    }
    var pin = document.UKLogin.cipher.value;
    var rand = document.UKLogin.randnum.value;

    /*	jsBase64 = new JavaScriptBase64;
     jsBase64.JavaScriptBase64("");
     jsBase64.string = pin; 
     document.UKLogin.userPIN.value=jsBase64.encode();*/
    if (pin == "") {
        $.messager.alert('消息', '请输入USB智能卡密码!');
        document.all.UK_cert.focus();
        return false;
    }

    try {
        if (SafeCtrl.USB_OpenDevice(0)) {
            SafeCtrl.USB_CloseDevice();
            $.messager.alert('消息', '未检测到智能卡！');
            return false;
        }
        if (SafeCtrl.USB_GenAuthReq(pin, servercert, rand)) {
            SafeCtrl.USB_CloseDevice();
            var errmsg = SafeCtrl.USB_GetLastError();
            $.messager.alert('消息', '产生认证请求失败，原因为：' + errmsg);
            return false;
        }
        var authreq = SafeCtrl.USB_GetAuthReq();
        SafeCtrl.USB_CloseDevice();
        document.UKLogin.cipher.value = authreq;
        return true;
    } catch (e) {
        $.messager.alert('消息', '客户端没有正确安装，请下载安装后再试！');
        return false;
    }
}
//证书文件登录验证
function doCertfileAuth() {
    // 检测控件
    if (window.safeCtrlCOMUnInstalled == true) {
        $.messager.alert('消息', '计算机没有安装安全认证控件, 请安装控件程序!');
        return false;
    }
    var pfxcert = document.CKLogin.tempfile.value;
    var rand = document.CKLogin.randnum.value;
    var pin = document.CKLogin.cipher.value;

    /*	jsBase64 = new JavaScriptBase64;
     jsBase64.JavaScriptBase64("");
     jsBase64.string = pin; 
     document.CKLogin.userPIN.value=jsBase64.encode();*/
    if (pfxcert == "") {
        $.messager.alert('消息', '请选择证书文件！');
        document.all.textfield.focus();
        return false;
    }

    if (pin == "") {
        $.messager.alert('消息', "请输入证书口令！");
        document.all.CK_cert.focus();
        return false;
    }

    try {
        //pfxcert = "测试帐号3.pfx";
        if (SafeCtrl.FILE_GenAuthReq(pin, pfxcert, servercert, rand)) {

            var errmsg = SafeCtrl.USB_GetLastError();
            $.messager.alert('消息', "产生认证请求失败，原因为：" + errmsg);
            return false;
        }

        var authreq = SafeCtrl.USB_GetAuthReq();
        document.CKLogin.cipher.value = authreq;
        console.log(authreq);
        return true;
    } catch (e) {
        $.messager.alert('消息', "认证控件没有正确安装，请下载安装后再试！");
        return false;
    }
}
//用户名口令登录
function doOtpAuth() {
    if (document.all.username.value == "") {
        $.messager.alert('消息', "请输入登录名！");
        document.all.username.focus();
        return false;
    }
    if (document.all.password.value == "") {
        $.messager.alert('消息', "请输入口令！");
        document.all.password.focus();
        return false;
    }
    return true;
}
//修改智能卡密码
function changeKeyPIN() {
    // 检测控件
    if (window.safeCtrlCOMUnInstalled == true) {
        $.messager.alert('消息', "计算机没有安装安全认证控件, 请安装控件程序!");
        return false;
    }
    var pin_old = document.all.KeyPIN_OLD.value;
    var pin_new1 = document.all.KeyPIN_NEW1.value;
    var pin_new2 = document.all.KeyPIN_NEW2.value;

    //验证是否为空
    if (!checkNull(pin_old, "请正确输入智能卡旧口令!")) {
        return false;
    }

    if (!checkNull(pin_new1, "请正确输入智能卡新口令!")) {
        return false;
    }

    if (!checkNull(pin_new2, "请正确输入智能卡确认口令!")) {
        return false;
    }
    // 验证新口令与就口令不能一致
    if (pin_old == pin_new1) {
        $.messager.alert('消息', "新口令不能与旧口令一致!");
        return false;
    }

    // 验证新口令与确认口令是否相同
    if (pin_new1 != pin_new2) {
        $.messager.alert('消息', "确认口令与新口令不一致!");
        return false;
    }

    // 验证口令长度
    if (pin_new1.length < 6 || pin_new1.length > 16) {
        $.messager.alert('消息', "口令长度不符合要求, 最小长度为6位, 最大长度为16位!");
        return false;
    }
    try {
        if (SafeCtrl.USB_OpenDevice(0)) {
            SafeCtrl.USB_CloseDevice();
            $.messager.alert('消息', "未检测到智能卡！");
            return false;
        }
        if (SafeCtrl.USB_ChangePin(1, pin_old, pin_new1)) {
            SafeCtrl.USB_CloseDevice();
            var errmsg = SafeCtrl.USB_GetLastError();
            $.messager.alert('消息', "修改智能卡密码失败，原因为：" + errmsg);
            return false;
        }
        SafeCtrl.USB_CloseDevice();
        document.all.KeyPIN_OLD.value = "";
        document.all.KeyPIN_NEW1.value = "";
        document.all.KeyPIN_NEW2.value = "";
        $('#win1').window('close');
        $.messager.alert('消息', "修改智能卡密码成功！");
        return true;
    } catch (e) {
        $.messager.alert('消息', "客户端没有正确安装，请下载安装后再试！");
        return false;
    }
}
//修改证书密码
function changeCertPIN() {
    // 检测控件
    if (window.safeCtrlCOMUnInstalled == true) {
        $.messager.alert('消息', "计算机没有安装安全认证控件, 请安装控件程序!");
        return false;
    }
    var pfxcert = document.all.textfield3.value;
    var cipher = document.all.CertPIN_OLD.value;
    var newPin = document.all.CertPIN_NEW1.value;
    var confirmPin = document.all.CertPIN_NEW2.value;
    //console.log(pfxcert+"@"+cipher+"@"+newPin+"@"+confirmPin);

    if (!checkNull(pfxcert, "请上传证书!")) {
        return false;
    }
    if (!checkNull(cipher, "请输入证书旧口令!")) {
        return false;
    }

    if (!checkNull(newPin, "请输入证书新口令!")) {
        return false;
    }

    if (!checkNull(confirmPin, "请输入证书确认口令!")) {
        return false;
    }

    // 验证新口令与就口令不能一致
    if (newPin == cipher) {
        $.messager.alert('消息', "新口令不能与旧口令一致!");
        return false;
    }

    // 验证新口令与确认口令是否相同
    if (newPin != confirmPin) {
        $.messager.alert('消息', "确认口令与新口令不一致!");
        return false;
    }

    // 验证口令长度
    if (newPin.length < 6 || newPin.length > 16) {
        $.messager.alert('消息', "口令长度不符合要求, 最小长度为6位, 最大长度为16位!");
        return false;
    }

    try {
        if (SafeCtrl.FILE_ChangePFXPass(pfxcert, cipher, newPin)) {
            var errmsg = SafeCtrl.USB_GetLastError();
            $.messager.alert('消息', "修改文件证书私钥口令失败, 原因为：" + errmsg);
            return false;
        }

        /*jsBase64.string = newPin;
         document.all.userPIN.value = jsBase64.encode();
         alert(document.all.userPIN.value);

         // 获取证书
         var sign = SafeCtrl.FILE_SignDataEx(newPin, pfxcert, "Sud23sAHk23lK");
         if(!checkNull(sign, "文件证书口令修改成功, 但获取证书信息失败!")){
         return false;
         }

         var userCert = SafeCtrl.FILE_ReadCertEx(0);
         if(!checkNull(userCert, "文件证书口令修改成功, 但获取证书信息失败!")){
         return false;
         }
         document.all.userCert.value = userCert;*/
        $('#win2').window('close');
        $.messager.alert('消息', "文件证书口令修改成功!");
        return true;
    }
    catch (e) {
        $.messager.alert('消息', "客户端没有正确安装, 请下载安装后再试!");
        return false;
    }
}
//校验是否为空
function checkNull(str, message) {
    str = "" + str;
    RegularExp = /^\s+|\s+$/gi;
    str = str.replace(RegularExp, "");
    if (str == "") {
        $.messager.alert('消息', message);
        return false;
    }
    return true;
}
