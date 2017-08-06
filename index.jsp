<html>

  <style>

    body
    {
      background-color: black;
    }

    h1
    {
      margin: 50px;
      padding: 50px;
      text-align: center;
      font-size: 100px;
    }

    .d1
    {
      border-radius: 50px;
      background-color: #ff4f2b;
      box-shadow: 5px;
      margin: 10px;
      padding: 10px;
    }

    .d2
    {
      border-radius: 50px;
      background-color: #83f74d;
      box-shadow: 5px;
      margin: 10px;
      padding: 10px;
    }

    .d3
    {
      border-radius: 50px;
      background-color: #f7e64d;
      box-shadow: 5px;
      margin: 10px;
      padding: 10px;
    }

  </style>

  <head>
    <title>Basement Lights</title>
  </head>

  <body>

   <div class="d1"> 
    <h1>Basement</h1>

    <div class="d2">
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
          out.println("<span id=\"light\" style=\"font-size: 50px; margin: auto; display: table; \">The lights are on</span>");
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
    
<div class="d3">
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

  var light=document.getElementById("light");
  
  //var oncol = "#69ebfa";
  var oncol = "#0717f7; "; //#799ced
  var offcol = "#0210cf";  //#91c6ff
  // var onattrib = "box-shadow: 0 5px #666; transform: translateY(7px);";
  // var offattrib = "box-shadow: 0 9px #999;";
   var onattrib = "box-shadow: 0 5px #02074a; transform: translateY(7px); border-color: #4754ff #7e87fc; ";
  var offattrib = "box-shadow: 0 12px #040d8c; border-color: #0717f7 #4754ff;";
  var on = offcol+offattrib;
  var off = offcol+offattrib;

  if(light != null)
  {
    on = oncol+onattrib;
    off = offcol+offattrib;
  }
  else
  {
    on = offcol+offattrib;
    off = oncol+onattrib;
  }

  var pad=Math.floor(w/3/7);

  var onStyle="height:"+Math.floor(h/3)+"px; width:"+Math.floor(w/3)+"px; padding:"+pad+"px; margin:"+pad+
              "px; font-size:50px; color: white; border-radius: 25px; background-color: "+on;

  var offStyle="height:"+Math.floor(h/3)+"px; width:"+Math.floor(w/3)+"px; padding:"+pad+"px; margin:"+pad+
              "px; font-size:50px; color: white; border-radius: 25px; background-color: "+off;            

  document.getElementById("onButton").setAttribute("style", onStyle);
  document.getElementById("offButton").setAttribute("style", offStyle);

  //trying to move outer div down a bit for mobile
  if(h > w)
  {
    document.getElementByClassName("d1").style["margin-top"] = "50px";
  }

</script>

</div></div></div>

  </body>
</html>
