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
        <title>Somme et moyenne de nombres</title>
    </head>
    <body>
        <a href="index.html">Revenir au menu principal</a><br>
        <h1>Somme et moyenne de nombres</h1>
        
        <%  
        try {
            // On récupère le "nombreDeNombres" dans un int nbDeNb utilisable dans les boucles
            String nombreDeNombres;
            if (request.getParameter("nombreDeNombres") != null && request.getParameter("nombreDeNombres") != "") nombreDeNombres = request.getParameter("nombreDeNombres");
            else nombreDeNombres = "0";
            int nbDeNb = Integer.parseInt(nombreDeNombres);
            if (nbDeNb < 0) nbDeNb = 0; // élimine les nombres négatifs
            
            // Si le bouton "Valider" n'a pas encore été actionné OU si aucun nombre n'a été entré OU si zéro a été entré, on affiche la demande de saisie du nombre de nombres à additionner 
            if (nbDeNb == 0) { // au lieu de : if (request.getParameter("nombreDeNombres") == null || request.getParameter("nombreDeNombres") == "" || request.getParameter("nombreDeNombres").equals("0")) {
                out.print("<form action='somme.jsp' method='POST'>");
                out.print("<label>Entrez le nombre de nombres dont vous voulez faire la somme et la moyenne : </label>");
                out.print("<input type='text' name='nombreDeNombres' size='3'/>");
                out.print("<input type='submit' value='Valider'/></form><br>");
            }
            
            if (nbDeNb > 0) { // Si un nombre supérieur à zéro a été entré
                
                // Je mets mon nombre (reçu grâce au bouton Valider) dans une session pour ne pas le perdre après envoi des valeurs avec le bouton "Sommes et moyenne"
                HttpSession sess = request.getSession(true);
                sess.setAttribute("nbDeNb", nbDeNb);
                
                // Création du form pour entrer tous les nombres avec en name n1, n2, n3, etc.
                out.print("<form action='somme.jsp' method='POST'>");
                for (int i = 1; i <= nbDeNb; i++) {
                    out.print("<label>Nombre " + i + " : </label><input type='text' name='n"+i+"' size='3'/><br>");
                }
                out.print("<br><input type='submit' value='Somme et moyenne'/></form>");
            }
            else { // si nbDeNb == 0, on n'affiche pas de champs de saisie de nombres, et si une valeur "nbDeNb" a été passée avec une session, cela signifie qu'il y a un calcul à faire et un résultat à renvoyer.
                if (session.getAttribute("nbDeNb") != null) { // S'il y a quelque chose dedans, il s'agit forcément d'un nombre supérieur à 0
                    
                    int nbDeNbEntres = 0;
                    double somme = 0;
                    double moyenne = 0;
                    double nbA;
                    String nombreActuel;
                    nbDeNb = (int) session.getAttribute("nbDeNb");
                    
                    for (int i = 1; i <= nbDeNb; i++) { // Additionne tous les nombres entrés
                        if (request.getParameter("n"+i) != null && request.getParameter("n"+i) != "") {
                            nombreActuel = request.getParameter("n"+i);
                            nbA = Double.parseDouble(nombreActuel);
                            somme += nbA;
                            nbDeNbEntres++; // Calcule le nombre réel de nombres entrés (on ne compte pas les champs vides)
                        }
                    }
                    
                    if (nbDeNbEntres > 0) { // On fait le calcul de la moyenne et on affiche les résultats si au moins un nombre a été entré.
                        moyenne = somme / nbDeNbEntres;
                        if (nbDeNbEntres == 1) out.println("1 nombre entré.<br>");
                        else out.println(nbDeNbEntres + " nombres entrés.<br>");
                        out.println("La somme de vos nombres est : " + somme + " et leur moyenne est : " + moyenne + "."); 
                    }
                    
                }
                
            }
            
        } catch(Exception e) { 
            out.print("***** !! Erreur : " + e.getMessage() + " *****"); 
        }
        
        // Questions : Cacher "somme.jsp" / passer par un lien <a href sans formulaire avec le dispatcher
        
        %>
        
    </body>
</html>
