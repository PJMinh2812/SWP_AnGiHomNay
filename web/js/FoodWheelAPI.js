/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


class FoodWheelAPI {
    constructor(baseUrl) {
        this.baseUrl = baseUrl || '';
    }
    
    async getCategories() {
        try {
            const response = await fetch(`${this.baseUrl}/api/categories`);
            const data = await response.json();
            return data.success ? data.data : [];
        } catch (error) {
            console.error('Error fetching categories:', error);
            return [];
        }
    }
    
    async getFoodsByCategory(category, limit = null) {
        try {
            const params = new URLSearchParams();
            if (category) params.append('category', category);
            if (limit) params.append('limit', limit);
            
            const response = await fetch(`${this.baseUrl}/api/foods?${params}`);
            const data = await response.json();
            return data.success ? data.data : [];
        } catch (error) {
            console.error('Error fetching foods:', error);
            return [];
        }
    }
    
    async getWheelData(category = null, customItems = null) {
        try {
            const params = new URLSearchParams();
            if (category) params.append('category', category);
            if (customItems) params.append('items', customItems);
            
            const response = await fetch(`${this.baseUrl}/api/wheel-data?${params}`);
            const data = await response.json();
            return data.success ? data.data : null;
        } catch (error) {
            console.error('Error fetching wheel data:', error);
            return null;
        }
    }
    
    async spinWheel(items) {
        try {
            const response = await fetch(`${this.baseUrl}/api/wheel-spin`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ items })
            });
            const data = await response.json();
            return data.success ? data.data : null;
        } catch (error) {
            console.error('Error spinning wheel:', error);
            return null;
        }
    }
    
    async getRandomFood(category = null, count = 1) {
        try {
            const params = new URLSearchParams();
            if (category) params.append('category', category);
            if (count) params.append('count', count);
            
            const response = await fetch(`${this.baseUrl}/api/random?${params}`);
            const data = await response.json();
            return data.success ? data.data : [];
        } catch (error) {
            console.error('Error getting random food:', error);
            return [];
        }
    }
}

// Usage in your wheel application
const foodAPI = new FoodWheelAPI('<%= request.getContextPath()%>');

// Load categories dynamically
async function loadCategoriesFromAPI() {
    const categories = await foodAPI.getCategories();
    const categorySelect = document.getElementById('categorySelect');
    
    categorySelect.innerHTML = '<option value="">-- Chọn danh mục --</option>';
    categories.forEach(category => {
        const option = document.createElement('option');
        option.value = category.name;
        option.textContent = category.name;
        categorySelect.appendChild(option);
    });
}

// Load foods by category using API
async function loadCategoryFoodsFromAPI() {
    const category = document.getElementById('categorySelect').value;
    if (!category) return;
    
    const wheelData = await foodAPI.getWheelData(category);
    if (wheelData && wheelData.items) {
        wheelItems = wheelData.items;
        updateItemsList();
        updateWheel();
    }
}

// Enhanced spin function with API
async function spinWheelWithAPI() {
    if (isSpinning || wheelItems.length === 0) return;
    
    const spinResult = await foodAPI.spinWheel(wheelItems);
    if (spinResult) {
        // Use API-provided animation data
        animateWheelSpin(spinResult.totalRotation, spinResult.selectedItem);
    }
}
