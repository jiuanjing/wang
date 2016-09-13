/*
 * Title  -> JavaScript Base64 Encoder Decoder
 * Author -> Paul Gration
 * URL    -> http://www.i-labs.org
 * Email  -> pmgration(at)i-labs.org
 */

function JavaScriptBase64() {
    var string;
    var base64;

    this.JavaScriptBase64 = function (string) {
        this.string = String(string);
        this.base64 = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
            'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
            'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
            'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
            'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
            'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
            'w', 'x', 'y', 'z', '0', '1', '2', '3',
            '4', '5', '6', '7', '8', '9', '*', '/'];
    };

    this.encode = function () {
        var binary = String();
        var result = String();
        for (i = 0; i < this.string.length; i++) {
            binary += String("00000000" + this.string.charCodeAt(i).toString(2)).substring(this.string.charCodeAt(i).toString(2).length);
        }
        for (i = 0; i < binary.length; i += 6) {
            var number = Number();
            var counter = Number();
            for (j = 0; j < binary.substring(i, i + 6).length; j++) {
                for (k = 32; k >= 1; k -= (k / 2)) {
                    if (binary.substring(i, i + 6).charAt(counter++) == "1") {
                        number += k;
                    }
                }
            }
            result += this.base64[number];
        }
        return result;
    };

    this.decode = function () {
        var binary = String();
        var result = String();
        for (i = 0; i < this.string.length; i++) {
            for (j = 0; j < this.base64.length; j++) {
                if (this.string.charAt(i) == this.base64[j]) {
                    binary += String("000000" + j.toString(2)).substring(j.toString(2).length);
                }
            }
        }
        for (i = 0; i < binary.length; i += 8) {
            var number = Number();
            var counter = Number();
            for (j = 0; j < binary.substring(i, i + 8).length; j++) {
                for (k = 128; k >= 1; k -= (k / 2)) {
                    if (binary.substring(i, i + 8).charAt(counter++) == "1") {
                        number += k;
                    }
                }
            }
            result += String.fromCharCode(number);
        }
        return result;
    }
}
