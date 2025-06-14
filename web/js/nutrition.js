/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function() {
    // Tab switching
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');
    
    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Remove active class from all buttons and contents
            tabButtons.forEach(btn => btn.classList.remove('active'));
            tabContents.forEach(content => content.classList.remove('active'));

            // Add active class to clicked button and corresponding content
            button.classList.add('active');
            const tabId = button.getAttribute('data-tab');
            document.getElementById(`${tabId}-tab`).classList.add('active');
        });
    });

// Calories search using CalorieNinjas API
const caloriesForm = document.getElementById('search-calories');
const caloriesResults = document.getElementById('calories-results');

caloriesForm.addEventListener('click', async () => {
    const foodName = document.getElementById('food-name').value;
    if (!foodName) return;

    try {
        const apiKey = 'oFhLgK1SqJwBPqAQAxwW/Q==zBLT9z62e26Wo8GB'; // ⛔ Replace with your actual API key
        const response = await fetch(`https://api.calorieninjas.com/v1/nutrition?query=${encodeURIComponent(foodName)}`, {
            headers: { 'X-Api-Key': apiKey }
        });

        const data = await response.json();
        const item = data.items[0];

        // Clear previous results
        caloriesResults.innerHTML = '';

        if (!item) {
            caloriesResults.innerHTML = '<tr><td colspan="11">Không tìm thấy dữ liệu dinh dưỡng</td></tr>';
            return;
        }

        // Create new row with actual API data
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${item.name}</td>
            <td>100g</td>
            <td>${item.calories}</td>
            <td>${item.fat_total_g}g</td>
            <td>${item.fat_saturated_g}g</td>
            <td>${item.cholesterol_mg}mg</td>
            <td>${item.sodium_mg}mg</td>
            <td>${item.carbohydrates_total_g}g</td>
            <td>${item.fiber_g}g</td>
            <td>${item.sugar_g}g</td>
            <td>${item.protein_g}g</td>
        `;
        caloriesResults.appendChild(row);
    } catch (error) {
        console.error('Lỗi khi gọi API dinh dưỡng:', error);
        caloriesResults.innerHTML = '<tr><td colspan="11">Đã xảy ra lỗi khi lấy dữ liệu</td></tr>';
    }
});

    // Ingredients search
    const ingredientsForm = document.getElementById('search-ingredients');
    const ingredientsResults = document.getElementById('ingredients-results');

    ingredientsForm.addEventListener('click', async () => {
        const recipeName = document.getElementById('recipe-name').value;
        const servings = document.getElementById('servings').value;
        if (!recipeName || !servings) return;

        try {
            // Mock data for different recipes
            const recipes = {
                'phở bò': [
                    { name: 'Thịt bò', quantity: 200, unit: 'g', image: 'images/foods/beef.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Bánh phở', quantity: 250, unit: 'g', image: 'images/foods/noodles.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Rau thơm', quantity: 50, unit: 'g', image: 'images/foods/herbs.jpg', type: 'Gia vị' },
                    { name: 'Hành lá', quantity: 30, unit: 'g', image: 'images/foods/green-onion.jpg', type: 'Gia vị' },
                    { name: 'Gừng', quantity: 20, unit: 'g', image: 'images/foods/ginger.jpg', type: 'Gia vị' }
                ],
                'bún chả': [
                    { name: 'Thịt heo', quantity: 300, unit: 'g', image: 'images/foods/pork.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Bún', quantity: 200, unit: 'g', image: 'images/foods/rice-vermicelli.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Rau sống', quantity: 100, unit: 'g', image: 'images/foods/vegetables.jpg', type: 'Rau ăn kèm' },
                    { name: 'Nước mắm', quantity: 50, unit: 'ml', image: 'images/foods/fish-sauce.jpg', type: 'Gia vị' }
                ],
                'cơm tấm': [
                    { name: 'Gạo tấm', quantity: 200, unit: 'g', image: 'images/foods/broken-rice.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Sườn heo', quantity: 250, unit: 'g', image: 'images/foods/pork-ribs.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Bì heo', quantity: 100, unit: 'g', image: 'images/foods/pork-skin.jpg', type: 'Nguyên liệu chính' },
                    { name: 'Chả trứng', quantity: 100, unit: 'g', image: 'images/foods/egg-meatloaf.jpg', type: 'Nguyên liệu chính' }
                ]
            };

            // Get recipe data
            const recipeKey = recipeName.toLowerCase();
            const recipeData = recipes[recipeKey] || [];

            // Clear previous results
            ingredientsResults.innerHTML = '';

            if (recipeData.length === 0) {
                ingredientsResults.innerHTML = '<p class="no-results">Không tìm thấy công thức cho món này</p>';
                return;
            }

            // Create ingredient items
            recipeData.forEach(ingredient => {
                const item = document.createElement('div');
                item.className = 'ingredient-item';
                const totalQuantity = ingredient.quantity * servings;
                item.innerHTML = `
                    <div class="ingredient-info">
                        <img src="${ingredient.image}" alt="${ingredient.name}" onerror="this.src='images/foods/placeholder.jpg'">
                        <div class="ingredient-details">
                            <h4>${ingredient.name}</h4>
                            <p>${ingredient.type}</p>
                        </div>
                    </div>
                    <div class="ingredient-quantity">${totalQuantity}${ingredient.unit}</div>
                `;
                ingredientsResults.appendChild(item);
            });
        } catch (error) {
            console.error('Error fetching ingredients data:', error);
        }
    });

    // Meal plan creation
    const createMealPlanBtn = document.querySelector('.meal-plan-container .btn-primary');
    const mealPlanGrid = document.querySelector('.meal-plan-grid');

    createMealPlanBtn.addEventListener('click', () => {
        // Clear previous meal plan
        mealPlanGrid.innerHTML = '';

        // Create days of the week
        const days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'];
        
        days.forEach(day => {
            const dayElement = document.createElement('div');
            dayElement.className = 'meal-day';
            dayElement.innerHTML = `
                <h4>${day}</h4>
                <div class="meal-item">
                    <h5>Bữa sáng</h5>
                    <p>Phở bò</p>
                </div>
                <div class="meal-item">
                    <h5>Bữa trưa</h5>
                    <p>Cơm tấm sườn</p>
                </div>
                <div class="meal-item">
                    <h5>Bữa tối</h5>
                    <p>Bún chả</p>
                </div>
            `;
            mealPlanGrid.appendChild(dayElement);
        });
    });
});