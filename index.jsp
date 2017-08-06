<html>

  <style>

    h1
    {
      margin: 50px;
      padding: 50px;
      text-align: center;
      font-size: 100px;
    }

  </style>

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
    //need to set up listener on file to do this, TomCat context listener should work
    	response.setIntHeader("Refresh", 60);


      Path file = FileSystems.getDefault().getPath("/home/pi/Documents/WebApps/Resources/switch");
      byte[] status = new byte[1];

      try
      {

        status = Files.readAllBytes(file);

        if(status[0]=='0')
          out.println("<span style=\"font-size: 50px; margin: auto; display: table;\">The lights are off</span>");
        else
          out.println("<span style=\"font-size: 50px; margin: auto; display: table; \">The lights are on</span>");
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
  <input type="submit" style="#" id="onButton" name="onButton" value="ON" />
  <input type="submit" style="#" id="offButton" name="offButton" value="OFF" />
</form>

<!--*********************END OF JSP, JS FOR SIZING*******************-->

<script type="text/javascript">
  
  var w = window.innerWidth
  || document.documentElement.clientWidth
  || document.body.clientWidth;

  var h = window.innerHeight
  || document.documentElement.clientHeight
  || document.body.clientHeight; 


  var pad=Math.floor(w/3/4.5);

  var bSize="height:"+Math.floor(h/3)+"px; width:"+Math.floor(w/3)+"px; padding:"+pad+"px; margin:"+pad+
              "px; font-size:50px; border-radius: 25px; background-color: #799ced;";

  document.getElementById("onButton").setAttribute("style", bSize);
  document.getElementById("offButton").setAttribute("style", bSize);

</script>



  </body>
</html>
