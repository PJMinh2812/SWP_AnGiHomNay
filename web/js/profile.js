/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function () {
    const favoriteButton = document.querySelector('.favorite-btn');

    favoriteButton.addEventListener('click', function () {
        window.location.href = 'favorites.jsp';
    });
});