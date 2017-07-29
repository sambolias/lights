<html>

  <head>
    <title>Basement Lights</title>
  </head>

  <body>

    <h1>Basement</h1>

    <%@ page import="java.lang.Process" %>
    <%@ page import="java.io.File" %>
    <%@ page import="java.nio.file.Files" %>
    <%@ page import="java.nio.file.Path" %>
    <%@ page import="java.nio.file.StandardOpenOption" %>
    <%@ page import="java.nio.file.FileSystems" %>
    <%
    	//set page to reload every 60 seconds (probably excessive)
    	response.setIntHeader("Refresh", 60);


      Path file = FileSystems.getDefault().getPath("/home/pi/Documents/WebApps/Resources/switch");
      byte[] status = new byte[1];

      try
      {
 //       file.resolve("/home/pi/Documents/WebApps/Resources/switch");
        status = Files.readAllBytes(file);

        if(status[0]=='0')
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
          byte[] s = new byte[1];
          s[0]='1';
          try
          {
            Files.write(file, s, StandardOpenOption.WRITE, StandardOpenOption.TRUNCATE_EXISTING);
          }
          catch(Exception e)
          {
            out.println("Couldn't write: "+e.toString());
          }
       	response.setHeader("REFRESH", "0");

      }

      if(request.getParameter("offButton") != null)
      {
                Process p = Runtime.getRuntime().exec("sudo /home/pi/Documents/c++/GPIO/GPIOcontrols/pout 4 0");
                p.waitFor();
                byte[] s = new byte[1];
                s[0]='0';
                try
                {
                	Files.write(file, s, StandardOpenOption.WRITE, StandardOpenOption.TRUNCATE_EXISTING);
		}
                catch(Exception e)
                {
                  out.println("Couldn't write: "+e.toString());
                }

       		 response.setHeader("REFRESH", "0");

	}


    %>


<form method="post">
<input type="submit" id="onButton" name="onButton" value="ON"  style="height:100px; width:100px; padding:50px; margin:50px"/>
<input type="submit" id="offButton" name="offButton" value="OFF" style="height:100px; width:100px; padding:50px; margin:50px"/>
</form>

  </body>
</html>
