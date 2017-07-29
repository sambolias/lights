<html>

  <head>
    <title>Test Page</title>
  </head>

  <body>
    <h1>Things are about to change</h1>
    <img src="images/buddy.jpg">
    <br/>    

    <%@ page import="java.lang.Process" %>
 
    <%
      out.println("Your IP address is "+request.getRemoteAddr());
      //Process proc = Runtime.getRuntime().exec("sudo /home/pi/Documents/c++/GPIO/GPIOcontrols/pout 4 1");
      //proc.waitFor();      
      if(request.getParameter("onButton") != null)
      {
      		Process p = Runtime.getRuntime().exec("sudo /home/pi/Documents/c++/GPIO/GPIOcontrols/pout 4 1");
                p.waitFor();
      }

      if(request.getParameter("offButton") != null)
      {
                Process p = Runtime.getRuntime().exec("sudo /home/pi/Documents/c++/GPIO/GPIOcontrols/pout 4 0");
                p.waitFor();
      }
    %>

    <!--form name="buttons" method="post">
       <input type="BUTTON" name="onButton" value="ON">
       <input type="BUTTON" name="offButton" value="OFF">
    </form-->
<form method="post">
<input type="submit" id="onButton" name="onButton" value="ON"/>
<input type="submit" id="offButton" name="offButton" value="OFF"/>
</form>  

  </body>
</html>



