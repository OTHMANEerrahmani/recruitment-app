# 📘 Guide Technique - RecruttAnty

Bienvenue dans la documentation technique de **RecruttAnty**. Ce document a pour but d'expliquer simplement comment fonctionne le code de l'application, destiné aux développeurs débutants ou à toute personne souhaitant comprendre l'architecture du projet.

---

## 🏗 Architecture Globale

L'application suit une architecture **MVC (Modèle-Vue-Contrôleur)** structurée en couches pour séparer les responsabilités.

```mermaid
graph TD
    A[Utilisateur (Navigateur)] -->|Requête HTTP| B(Contrôleur / Servlet);
    B -->|Appelle| C(Service);
    C -->|Utilise| D(DAO - Data Access Object);
    D -->|Lit/Ecrit| E[(Base de Données / Entités JPA)];
    B -->|Renvoie| F(Vue JSP);
    F -->|Réponse HTML| A;
```

### Rôle des Couches
1.  **Vue (JSP)** : Ce que l'utilisateur voit (pages HTML).
2.  **Contrôleur (Servlet)** : Reçoit les demandes de l'utilisateur, traite les données via les Services, et choisit quelle page afficher.
3.  **Service** : Contient la logique métier (règles de gestion, calculs, vérifications).
4.  **DAO** : Gère uniquement l'accès aux données (SQL via JPA).
5.  **Entité (Model)** : Représente les tables de la base de données sous forme d'objets Java.

---

## 📂 Détail du Package `java/com/recruitment`

Voici une explication fichier par fichier du code source Java.

### 1. 🛂 Controllers (`com.recruitment.controller`)
Les Servlets sont les "aiguilleurs" de l'application.

| Fichier | Rôle | URL (Route) |
| :--- | :--- | :--- |
| `AuthServlet.java` | Gère l'inscription (`/auth/register`), la connexion (`/auth/login`) et la déconnexion (`/auth/logout`). | `/auth/*` |
| `AdminServlet.java` | Affiche le tableau de bord administrateur (liste des utilisateurs). | `/admin/dashboard` |
| `AdminCandidateProfileServlet.java` | Permet à l'admin de voir le profil complet d'un candidat. | `/admin/candidate-profile` |
| `AdminCompanyOffersServlet.java` | Permet à l'admin de voir les offres d'une entreprise. | `/admin/company-offers` |
| `AdminDeleteJobOfferServlet.java` | Gère la suppression d'une offre (avec sécurité transactionnelle). | `/admin/delete-offer` |
| `CandidateServlet.java` | Gère le tableau de bord candidat et la mise à jour du profil. | `/candidate/*` |
| `CompanyServlet.java` | Gère le tableau de bord entreprise (création d'offres, vue des candidats). | `/company/*` |
| `MessageServlet.java` | Gère l'envoi de messages entre recruteurs et candidats. | `/message/*` |
| `NotificationServlet.java` | Gère l'affichage des notifications. | `/notifications` |

### 2. 🧠 Services (`com.recruitment.service`)
La couche "intelligente" qui applique les règles métier.

*   **`UserService`** : Gestion des utilisateurs (création, recherche, suppression en cascade).
*   **`AuthService`** : Vérification des mots de passe et authentification.
*   **`JobService`** : Gestion des offres d'emploi (création, suppression conditionnelle).
*   **`EmailService` / `SmsService`** : (Simulation) Envoi de communications externes.
*   **`NotificationService`** : Création et gestion des alertes pour les utilisateurs.

### 3. 💾 DAO (`com.recruitment.dao`)
La couche qui "parle" à la base de données.

*   **`AbstractDAO` / `GenericDAO`** : Classes parentes fournissant les méthodes de base (`save`, `update`, `delete`, `findById`) pour éviter de répéter du code.
*   **`UserDAO`** : Requêtes spécifiques aux utilisateurs (ex: `findByEmail`).
*   **`JobOfferDAO`** : Requêtes pour les offres (ex: `findByCompanyId`).
*   **`ApplicationDAO`** : Requêtes pour les candidatures (ex: `countAcceptedByJobOfferId`).
*   **`MessageDAO`** : Récupération des conversations.
*   **`NotificationDAO`** : Récupération des notifications non lues.

### 4. 📦 Entities (`com.recruitment.entity`)
Les objets Java qui correspondent exactement aux tables de la base de données.

*   **`User`** (Table `users`) : Classe mère pour tous les comptes. Contient email, mot de passe, rôle.
    *   **`Candidate`** (extends User) : Ajoute Nom, Prénom, Compétences, CV.
    *   **`Company`** (extends User) : Ajoute Nom de l'entreprise, Adresse.
    *   **`Admin`** (extends User) : (Peut ajouter des droits spécifiques).
*   **`JobOffer`** (Table `job_offers`) : Une offre d'emploi. Liée à une `Company`.
*   **`Application`** (Table `applications`) : Lien entre un `Candidate` et une `JobOffer`. Contient le statut (PENDING, ACCEPTED, REJECTED).
*   **`Message`** (Table `messages`) : Message échangé. Lié à une `JobOffer`, un `Candidate` et l'auteur (sender).
*   **`Notification`** (Table `notifications`) : Alerte pour un utilisateur.

### 5. 🛠 Util (`com.recruitment.util`)
*   **`JPAUtil`** : Fournit l'objet `EntityManager` nécessaire pour toutes les opérations de base de données. C'est le point d'entrée de JPA (Hibernate).

---

## 🗄 Structure de la Base de Données

Voici comment les données sont liées :

*   **1 Utilisateur (Company)** peut créer **N Offres**.
*   **1 Utilisateur (Candidate)** peut postuler à **N Offres** (via la table `applications`).
*   **1 Offre** reçoit **N Candidatures**.
*   **1 Candidature** génère une conversation de **N Messages**.

### Relations Clés (JPA)
*   `@ManyToOne` / `@OneToMany` : Utilisé pour relier `JobOffer` -> `Company`.
*   `@Inheritance(strategy = InheritanceType.JOINED)` : Utilisé sur `User` pour gérer les types `CANDIDATE`, `COMPANY`, `ADMIN` dans des tables séparées mais liées.

---

## 🔄 Flux de Navigation & Interactions

Comment le Java parle au Web (JSP) :

### Exemple 1 : Afficher le Dashboard Admin
1.  **Navigateur** : L'utilisateur va sur `/admin/dashboard`.
2.  **Web.xml** : Redirige vers `AdminServlet`.
3.  **Servlet (`doGet`)** :
    *   Appelle `userService.findAll()` pour récupérer la liste.
    *   Met la liste dans la requête : `req.setAttribute("users", userList)`.
    *   Transfère à la vue : `req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(...)`.
4.  **JSP (`dashboard.jsp`)** : Lit la liste `${users}` et génère le tableau HTML.

### Exemple 2 : Supprimer une Offre (Formulaire)
1.  **JSP (`company_offers.jsp`)** : L'admin clique sur "Delete". Un formulaire caché envoie une requête POST vers `/admin/delete-offer`.
2.  **Servlet (`AdminDeleteJobOfferServlet`)** :
    *   Récupère l'ID : `req.getParameter("id")`.
    *   Appelle `jobService.deleteJobOffer(id)`.
3.  **Service (`JobService`)** :
    *   Vérifie la règle métier : "Y a-t-il un candidat accepté ?".
    *   Si OUI : Lance une transaction, supprime Messages -> Notifications -> Applications -> Offre.
    *   Si NON : Lance une exception.
4.  **Servlet** :
    *   Si succès : `session.setAttribute("message", "Deleted")`.
    *   Redirige vers la liste : `resp.sendRedirect(...)`.

---

## 🚀 Pour Démarrer

Pour comprendre le code, commencez par regarder :
1.  **`User.java`** : Pour voir comment les données sont structurées.
2.  **`AuthServlet.java`** : Pour voir comment on gère les requêtes HTTP simples.
3.  **`UserService.java`** : Pour voir la logique métier.

Ce projet est conçu pour être modulaire : si vous voulez ajouter une fonctionnalité, vous créerez probablement une nouvelle **Servlet**, un nouveau **JSP**, et peut-être une méthode dans un **Service** existant.
