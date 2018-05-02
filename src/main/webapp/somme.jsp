<%-- 
    Document   : somme
    Created on : 30 avr. 2018, 15:52:59
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
        <h1>Somme et moyenne de nombres</h1>
            <form action="somme.jsp" method="POST">
            <label>Entrez le nombre de nombres dont vous voulez faire la moyenne : </label>
            <input type="text" name="nombreDeNombres" size="3"/>
            <input type="submit" value="Valider"/>
            </form>
        <br>
        <%
            String nombreDeNombres;
            if (request.getParameter("nombreDeNombres") != null && request.getParameter("nombreDeNombres") != "") nombreDeNombres = request.getParameter("nombreDeNombres");
            else nombreDeNombres = "0";
            int nbDeNb = Integer.parseInt(nombreDeNombres);
            
            if (nbDeNb > 0) {
                for (int i = 1; i <= nbDeNb; i++) {
                    
                    out.print("<label>Nombre " + i + " : </label><input type='text' name='n"+i+"' size='3'/><br>");
                    
                    // reel = sc.nextDouble(); // La console de NetBeans ne prend pas le . mais la , avant les décimales, sinon ça plante.

                    // somme = somme + reel;

                }
                out.print("<br><input type='submit' value='Somme et moyenne'/>");
            }
            else {
                double reel;
                double somme = 0;
                double moyenne = 0;

                
                moyenne = somme / nbDeNb;
                out.println("La somme de vos nombres est : " + somme + " et leur moyenne est : " + moyenne + ".");
            }
            
        /*    
        


*/
        %>
        
    </body>
</html>
