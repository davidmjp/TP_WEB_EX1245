<%-- 
    Document   : devinez
    Created on : 2 mai 2018, 09:38:11
    Author     : Formation
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css"/>
        <title>Devinez le nombre</title>
    </head>
    <body onload="document.forms['monF'].elements['nombreSaisi'].focus()">
        <h1>Devinez le nombre entre 1 et 100 inclus</h1>
        
        <%
        try {
        Random random = new Random();
        int nA=0, nS=0, nAlePlusGrand=0, bestNbCoups=1000, compteur=0; // nombre aléatoire, nombre saisi
        String nombreSaisi = "0"; // Je donne une valeur parce que mon affectation est dans un if
        boolean premiereFois = false; // pour la première fois qu'on arrive sur la page, pour afficher "devinez" dans le span2
        List<Integer> listeNs = new ArrayList<>();
        if (session.getAttribute("listeNs") != null) listeNs = (List<Integer>) session.getAttribute("listeNs");
        
        // Je récupère mon nombre aléatoire s'il existe (session), sinon je le génère (+ session), OU je génère si le bouton Nouvelle partie a été cliqué
        if (session.getAttribute("nA") != null) nA = (int) session.getAttribute("nA");
        if (session.getAttribute("nA") == null || request.getParameter("new") != null) { // inutile d'ajouter : && request.getParameter("new").equals("Nouvelle partie")
            
            // HttpSession sess = request.getSession(true); // Création d'une session (1 seule session dans la page, mais plusieurs setAttribute possibles)
            // En fait l'objet "session" existe déjà dans une jsp, il faut donc pas utiliser la ligne précédente (pas de création de session ici) !
            
            // Si on appuie sur le bouton Nouvelle partie
            if (request.getParameter("new") != null) listeNs.clear(); // Pour rejouer, on efface la liste des nombres saisis par l'utilisateur
            else session.setAttribute("nAlePlusGrand", 0); // 0 pour la première fois que la page s'affiche : on affichera un ? à la place
            
            // On tire un nouveau nombre au hasard
            nA = random.nextInt(100);
            if (nA == 0) nA = 1;
            session.setAttribute("nA", nA);
            premiereFois = true;
        }
        
        // Je récupère le nombre saisi par l'utilisateur
        if (request.getParameter("nombreSaisi") != null && request.getParameter("nombreSaisi") != "") {
            nombreSaisi = request.getParameter("nombreSaisi");
            nS = Integer.parseInt(nombreSaisi);
            listeNs.add(nS); // ajout et session de ma liste pour voir la liste des nombres saisis
            session.setAttribute("listeNs", new ArrayList<Integer>(listeNs));
            
            if (session.getAttribute("compteur") != null) compteur = (int) session.getAttribute("compteur");
            compteur++;
            session.setAttribute("compteur", compteur);
        }
        
        // Je récupère le nombre le plus grand à deviner choisi en aléatoire depuis le début des parties.
        if (session.getAttribute("nAlePlusGrand") != null) nAlePlusGrand = (int) session.getAttribute("nAlePlusGrand");
        
        // On n'affiche le formulaire pour pouvoir envoyer un nombre que si le bon nombre n'a pas encore été trouvé.
        if (nA != nS) out.print("<form name='monF' action='devinez.jsp' method='post'>");
        %>
        <span id='span1'>Saisie du nombre : </span>
        <input type='text' name='nombreSaisi' size='3'/>
        <input type='submit' value='Jouer'/>
        <% if (nA != nS) out.print("</form>"); %>
        
        <br>
        <span id="span2">
            <%
                if (request.getParameter("new") != null || premiereFois == true || request.getParameter("nombreSaisi") == "") out.print("Devinez ("+nA+")"); // Ne marche pas parce qu'on vient de lui donner une valeur juste au-dessus : session.getAttribute("nA") == null) 
                else {
                    if (nA > nS) out.print("Plus grand !");
                    if (nA < nS) out.print("Plus petit !");
                }
                
                if (nA == nS) {
                    out.println("Vous avez trouvé ! Félicitations !");
                    out.println("</span><form action='devinez.jsp' method='post'><input type='submit' name='new' value='Nouvelle partie'/></form>");
                    
                    // à partir du deuxième nombre à trouver, j'actualise le nombre le plus grand si nA est plus grand que le nombre le plus grand précédemment enregistré.
                    nAlePlusGrand = (int) session.getAttribute("nAlePlusGrand");
                    if (nA > nAlePlusGrand) {
                        session.setAttribute("nAlePlusGrand", nA);
                        nAlePlusGrand = nA;
                    }
                    
                    // Récupération du compteur et de bestNbCoups, comparaison, réinitialisation de bestNbCoups (si on a trouvé le nombre en un moins grand nombre de coups) et du compteur à zéro
                    compteur = (int) session.getAttribute("compteur");
                    if (session.getAttribute("bestNbCoups") != null) bestNbCoups = (int) session.getAttribute("bestNbCoups");
                    if (compteur < bestNbCoups) {
                        session.setAttribute("bestNbCoups", compteur);
                        bestNbCoups = compteur;
                    }
                    session.setAttribute("compteur", 0);
                }
                else out.print("</span>");
            %>
        
        <br>
        
        <p><span class="gauche">
            <%
                if (listeNs.size() > 0) out.print(listeNs);
            %>
            </span><span class="droite">Plus grande valeur du<br>Random trouvée :<br><br>
            <% 
                if (nAlePlusGrand == 0) out.print("?");
                else out.print(nAlePlusGrand);
                
                out.print("<br><br>Meilleur nombre<br>de coups :<br><br>");
                if (session.getAttribute("bestNbCoups") != null) bestNbCoups = (int) session.getAttribute("bestNbCoups");
                if (bestNbCoups == 1000) out.print("?");
                else out.print(bestNbCoups);
            %>    
            </span>
        </p>
    </body>
</html>

        <%
        } catch(Exception e) { // Pour réafficher la page sans voir de message d'erreur si n'importe quoi a été entré par l'utilisateur
            out.print("<form id='monF' action='devinez.jsp' method='post'>");
            out.print("<input name='nombreSaisi' type='submit' value='0'/></form>");
            out.print("<script type='text/javascript'>document.getElementById('monF').submit();</script>"); // Envoi automatique du formulaire
        }
        %>

