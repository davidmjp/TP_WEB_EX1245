<%-- 
    Document   : agetaille
    Created on : 4 mai 2018, 11:32:52
    Author     : Formation
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Âge et taille</title>
    </head>
    <body>
        <a href="index.html">Revenir au menu</a><br>
        <center><br>
        <h1>Âge et taille</h1>
        <br>
        <form action="agetaille.jsp">
            <label>Votre âge (en années) : </label><input type="text" name="age" size="3">
            <label>Votre taille (en cm) : </label><input type="text" name="taille" size="3">
            <br><br><input type="submit" value="Voir ce que le programme en dit">
        </form>
        <br><br>
        
        <%
        try {
            String ageS, tailleS;
            int age, taille;

            if (request.getParameter("age") != null) ageS = request.getParameter("age");
            else ageS = "0";
            if (request.getParameter("taille") != null) tailleS = request.getParameter("taille");
            else tailleS = "0";
            age = Integer.parseInt(ageS);
            taille = Integer.parseInt(tailleS);
            
            if (age > 0 && taille > 0) {
                if (age > 20 && taille < 100) out.println("Vous êtes peut-être un nain adulte ?");
                else if (age > 20 && taille > 200) out.println("Vous êtes un géant adulte :)");
                else if (age < 3 && taille < 50) out.println("Vous êtes peut-être un bébé :)");
                else if (age >= 15 && age <= 18 && taille >= 150 && taille <= 180) out.println("Vous êtes un ado !");
                else if (age == 39 || age == 40 && taille == 183) out.println("Vous vous appelez peut-être David ?");
                else out.println("Rien à dire pour cet âge avec cette taille.");
            }
            else out.println("Il faut que l'âge et la taille soient supérieurs à zéro.");
        } catch(Exception e) {
            out.println(e.getMessage());
        }
        %>
        </center>
    </body>
</html>
