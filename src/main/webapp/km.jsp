<%-- 
    Document   : km
    Created on : 30 avr. 2018, 14:59:53
    Author     : Formation
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="index.html">Revenir au menu</a><br>
        <h1>Un kilomètre à pied...</h1>  
        <%
            for (int i = 1; i <= 15; i++) {
                out.print(i + " kilomètre");
                if (i>1) out.print("s");
                out.print(" à pied, ça use, ça use,\n" + i + " kilomètre");
                if (i>1) out.print("s");
                out.println(" à pied, ça use les souliers.<br>");
            }
        %>
    </body>
</html>
