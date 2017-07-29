<html>

  <head>
    <title>Basement Lights</title>
  </head>

  <body>

    <h1>Basement</h1>
    <%@ page import="java.lang.Process" %>
    <%@ page import="java.io.File" % >
    <%@ page import="java.nio.file.Files" %>

    <%

      Path file = "/home/pi/Documents/WebApps/Resources/switch";
      byte[] switch;

      try
      {
        switch = Files.readAllBytes(file);

        if(switch[0]=='0')
          out.println("The lights are off");
        else
          out.println("The lights are on");
      }
      catch(Exception e)
      {
        out.println("Couldn't read file: "+e.toString());
      }

      if(request.getParameter("onButton") != null)
      {
      		Process p = Runtime.getRuntime().exec("sudo /home/pi/Documents/c++/GPIO/GPIOcontrols/pout 4 1");
                p.waitFor();
          byte[] s = '1';
          try
          {
            Files.write(file, s, WRITE, TRUNCATE_EXISTING);
          }
          catch(Exception e)
          {
            out.println("Couldn't write: "+e.toString());
          }
      }

      if(request.getParameter("offButton") != null)
      {
                Process p = Runtime.getRuntime().exec("sudo /home/pi/Documents/c++/GPIO/GPIOcontrols/pout 4 0");
                p.waitFor();
                byte[] s = '0';
                try
                {
                  Files.write(file, s, WRITE, TRUNCATE_EXISTING);
                }
                catch(Exception e)
                {
                  out.println("Couldn't write: "+e.toString());
                }
      }


    %>


<form method="post">
<input type="submit" id="onButton" name="onButton" value="ON"  style="height:50px; width:50px"/>
<input type="submit" id="offButton" name="offButton" value="OFF" style="height:50px; width:50px"/>
</form>

  </body>
</html>
