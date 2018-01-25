IMPORT util
IMPORT os
IMPORT FGL fgldialog
MAIN
  DEFINE html STRING
  DEFINE result STRING
  MENU "Test"
  COMMAND "Generate Hello World"
    LET html = "<html><body>Hello World</body></html>"
    CALL ui.Interface.frontCall("cordova","call",[
       "PDFService","htmlToPDF", NULL, html, "A4", "portrait", "base64"],result)
    IF result.getLength()>0 THEN
      TRY
        CALL util.Strings.base64Decode(result,"result.pdf")
        CALL ui.Interface.frontCall("standard","launchurl",[os.Path.join(os.Path.pwd(),"result.pdf")],[])
      CATCH
        CALL fgldialog.fgl_winMessage("Error",err_get(status),"info")
      END TRY
    END IF
  COMMAND "Exit"
    EXIT MENU
  END MENU
END MAIN
